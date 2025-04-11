// features/chapters_screen.dart
import 'package:flutter/material.dart';
import 'chapter_screen.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final bookName = args['bookName'];
    final chaptersCount = args['chaptersCount'];

    return Scaffold(
      appBar: AppBar(title: Text(bookName)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: chaptersCount,
        itemBuilder: (context, index) {
          final chapter = index + 1;
          return ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/chapter',
                arguments: {'bookName': bookName, 'chapter': chapter},
              );
            },
            child: Text('$chapter'),
          );
        },
      ),
    );
  }
}
