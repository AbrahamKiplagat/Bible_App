import 'package:flutter/material.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

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
          : LayoutBuilder(
              builder: (context, constraints) {
                // Adjust grid layout based on screen size
                if (constraints.maxWidth > 800) {
                  return _buildChapterGrid(context, bookName, chaptersCount, 10);
                } else if (constraints.maxWidth > 600) {
                  return _buildChapterGrid(context, bookName, chaptersCount, 7);
                } else {
                  return _buildChapterGrid(context, bookName, chaptersCount, 5);
                }
              },
            ),
    );
  }

  Widget _buildChapterGrid(
      BuildContext context, String bookName, int count, int columns) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        final chapter = index + 1;
        return FilledButton(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.zero, // Better for small screens
          ),
          onPressed: () => _navigateToChapter(context, bookName, chapter),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$chapter',
              style: TextStyle(
                fontSize: _calculateFontSize(context, columns),
              ),
            ),
          ),
        );
      },
    );
  }

  double _calculateFontSize(BuildContext context, int columns) {
    final width = MediaQuery.of(context).size.width;
    // Scale font size based on screen width and number of columns
    return width / columns / 3;
  }

  void _navigateToChapter(BuildContext context, String bookName, int chapter) {
    Navigator.pushNamed(
      context,
      '/chapter',
      arguments: {
        'bookName': bookName,
        'chapter': chapter,
        'key': '$bookName-$chapter',
      },
    );
  }

  Widget _buildErrorScreen(String message) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('No chapters available'),
      ),
    );
  }
}