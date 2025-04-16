import 'package:flutter/material.dart';
import '../data/bible_books.dart'; // Import bibleBooks data
import 'chapters_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Books'),
        actions: [
          
        ],
      ),
      body: ListView.builder(
        itemCount: bibleBooks.length,  // Using bibleBooks data
        itemBuilder: (context, index) {
          final book = bibleBooks[index];
          return ListTile(
            title: Text(book['name']),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/chapters',
                arguments: {'bookName': book['name'], 'chaptersCount': book['chapters']},
              );
            },
          );
        },
      ),
    );
  }
}
