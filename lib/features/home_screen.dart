import 'package:flutter/material.dart';
import '../data/bible_books.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Books'),
        // Suggested: Add search action
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: bibleBooks.isEmpty
          ? const Center(child: Text('No books available'))
          : ListView.separated( // Suggested: Use separated for better visuals
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
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chapters',
                      arguments: {
                        'bookName': book['name'],
                        'chaptersCount': book['chapters'],
                        'bookId': book['id'], // Suggested: Add book ID
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}