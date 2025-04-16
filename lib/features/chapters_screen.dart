import 'package:flutter/material.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    // Enhanced error handling
    if (args == null || args is! Map<String, dynamic>) {
      return _buildErrorScreen('Invalid book data');
    }

    final bookName = args['bookName'] as String? ?? 'Unknown Book';
    final chaptersCount = args['chaptersCount'] as int? ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(bookName),
        centerTitle: true,
      ),
      body: chaptersCount <= 0
          ? _buildEmptyState()
          : _buildChapterGrid(context, bookName, chaptersCount),
    );
  }

  Widget _buildChapterGrid(BuildContext context, String bookName, int count) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Suggested: Responsive grid
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        final chapter = index + 1;
        return FilledButton( // Suggested: Use FilledButton for M3
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => _navigateToChapter(context, bookName, chapter),
          child: Text('$chapter'),
        );
      },
    );
  }

  void _navigateToChapter(BuildContext context, String bookName, int chapter) {
    Navigator.pushNamed(
      context,
      '/chapter',
      arguments: {
        'bookName': bookName,
        'chapter': chapter,
        'key': '$bookName-$chapter', // Suggested: Unique key for caching
      },
    );
  }

  Widget _buildErrorScreen(String message) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(message)),
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: Text('No chapters available'));
  }
}