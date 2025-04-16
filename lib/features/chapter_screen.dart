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
        title: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust title based on available space
            if (constraints.maxWidth < 300) {
              return Text(
                _headerTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            }
            return Text(_headerTitle);
          },
        ),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        snapshot.error?.toString() ?? 'No verse data',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _refreshChapter,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use different padding based on screen size
        final padding = constraints.maxWidth > 600 ? 24.0 : 16.0;
        
        return ListView.separated(
          padding: EdgeInsets.all(padding),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemCount: verses.length,
          itemBuilder: (context, index) {
            final verse = verses[index];
            return Card(
              elevation: constraints.maxWidth > 600 ? 2 : 1,
              child: Padding(
                padding: EdgeInsets.all(padding / 2),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${verse['verse']}. ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: constraints.maxWidth > 600 ? 18 : 16,
                        ),
                      ),
                      TextSpan(
                        text: verse['text'],
                        style: TextStyle(
                          fontSize: constraints.maxWidth > 600 ? 18 : 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _refreshChapter() {
    setState(() {
      _versesFuture = _apiService.fetchChapter(
        (ModalRoute.of(context)?.settings.arguments as Map)['bookName'],
        (ModalRoute.of(context)?.settings.arguments as Map)['chapter'],
      );
    });
  }
}