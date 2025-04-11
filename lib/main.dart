import 'package:flutter/material.dart';
import 'features/home_screen.dart';
import 'features/chapters_screen.dart';
import 'features/chapter_screen.dart';
import 'features/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(), // Home screen (List of Books)
        '/chapters': (context) => const ChaptersScreen(), // Chapters screen (List of Chapters)
        '/chapter': (context) => const ChapterScreen(), // Specific chapter with verses
        '/search': (context) => const SearchScreen(), // Search screen
      },
    );
  }
}
