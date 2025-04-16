import 'package:flutter/material.dart';
import 'features/home_screen.dart';
import 'features/chapters_screen.dart';
import 'features/chapter_screen.dart';
import 'features/welcome_ui.dart';

void main() {
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
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/welcome',
onGenerateRoute: (settings) {
  switch (settings.name) {
    case '/welcome':
      return MaterialPageRoute(builder: (_) => const WelcomeScreen());
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