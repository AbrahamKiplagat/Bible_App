import 'package:flutter/material.dart';
import '../core/api_service.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key});

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final BibleApiService _apiService = BibleApiService();
  late Future<List<Map<String, dynamic>>> _versesFuture;
  String _headerTitle = 'Chapter Verses';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadChapterData();
  }

  Future<void> _loadChapterData() async {
    final args = ModalRoute.of(context)?.settings.arguments;
    
    if (args == null || args is! Map<String, dynamic>) {
      setState(() => _headerTitle = 'Error');
      _versesFuture = Future.error('Invalid chapter data');
      return;
    }

    final bookName = args['bookName'] as String? ?? 'Unknown Book';
    final chapter = args['chapter'] as int? ?? 1;

    setState(() => _headerTitle = '$bookName $chapter');
    _versesFuture = _apiService.fetchChapter(bookName, chapter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_headerTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshChapter,
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _versesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 16),
                  Text(snapshot.error?.toString() ?? 'No verse data'),
                  TextButton(
                    onPressed: _refreshChapter,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final verses = snapshot.data!;
          return _buildVerseList(verses);
        },
      ),
    );
  }

  Widget _buildVerseList(List<Map<String, dynamic>> verses) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: verses.length,
      itemBuilder: (context, index) {
        final verse = verses[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${verse['verse']}. ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: verse['text']),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _refreshChapter() {
    setState(() {
      _versesFuture = _apiService.fetchChapter(
        // Extract arguments again in case they changed
        (ModalRoute.of(context)?.settings.arguments as Map)['bookName'],
        (ModalRoute.of(context)?.settings.arguments as Map)['chapter'],
      );
    });
  }
}