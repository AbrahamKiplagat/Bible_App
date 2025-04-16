import 'package:flutter/material.dart';
import '../data/bible_books.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: bibleBooks.isEmpty
          ? const Center(child: Text('No books available'))
          : LayoutBuilder(
              builder: (context, constraints) {
                // Use different layouts based on screen width
                if (constraints.maxWidth > 800) {
                  return _buildWideLayout(context);
                } else if (constraints.maxWidth > 600) {
                  return _buildMediumLayout(context);
                } else {
                  return _buildNarrowLayout(context);
                }
              },
            ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return ListView.separated(
      itemCount: bibleBooks.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final book = bibleBooks[index];
        return ListTile(
          title: Text(
            book['name'],
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _navigateToChapters(context, book),
        );
      },
    );
  }

  Widget _buildMediumLayout(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 4,
      ),
      itemCount: bibleBooks.length,
      itemBuilder: (context, index) {
        final book = bibleBooks[index];
        return Card(
          child: ListTile(
            title: Text(
              book['name'],
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            onTap: () => _navigateToChapters(context, book),
          ),
        );
      },
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3,
      ),
      itemCount: bibleBooks.length,
      itemBuilder: (context, index) {
        final book = bibleBooks[index];
        return Card(
          elevation: 2,
          child: InkWell(
            onTap: () => _navigateToChapters(context, book),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  book['name'],
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToChapters(BuildContext context, Map<String, dynamic> book) {
    Navigator.pushNamed(
      context,
      '/chapters',
      arguments: {
        'bookName': book['name'],
        'chaptersCount': book['chapters'],
        'bookId': book['id'],
      },
    );
  }
}