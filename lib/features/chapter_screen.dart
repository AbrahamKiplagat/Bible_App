// features/chapter_screen.dart
import 'package:flutter/material.dart';
import '../core/api_service.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key});

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final BibleApiService apiService = BibleApiService();
  late Future<List<Map<String, dynamic>>> versesFuture;

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final bookName = args['bookName'];
    final chapter = args['chapter'];

    versesFuture = apiService.fetchChapter(bookName, chapter);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chapter Verses')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: versesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final verses = snapshot.data!;
            return ListView.builder(
              itemCount: verses.length,
              itemBuilder: (context, index) {
                final verse = verses[index];
                return ListTile(
                  title: Text('${verse['verse']}. ${verse['text']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
