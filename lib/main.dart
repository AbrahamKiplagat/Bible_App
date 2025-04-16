import 'package:flutter/material.dart';
import 'features/home_screen.dart';
import 'features/chapters_screen.dart';
import 'features/chapter_screen.dart';

void main() {
  // Suggested: Add error handling wrapper
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        // Suggested: Add consistent text theme
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      // Suggested: Use onGenerateRoute for better error handling
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/chapters':
            return MaterialPageRoute(
              builder: (_) => const ChaptersScreen(),
              settings: settings,
            );
          case '/chapter':
            return MaterialPageRoute(
              builder: (_) => const ChapterScreen(),
              settings: settings,
            );
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('Route ${settings.name} not found'),
                ),
              ),
            );
        }
      },
    );
  }
}