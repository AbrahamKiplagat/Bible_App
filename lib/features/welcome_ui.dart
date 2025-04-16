import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _verseController = PageController();
  final List<Map<String, String>> bibleVerses = [
   
    {
      'verse': '"I can do all things through him who strengthens me."',
      'reference': 'Philippians 4:13'
    },
    {
      'verse': '"Trust in the Lord with all your heart, and do not lean on your own understanding."',
      'reference': 'Proverbs 3:5'
    },
    {
      'verse': '"The Lord is my shepherd; I shall not want."',
      'reference': 'Psalm 23:1'
    },
   {
  'verse': '"Fear not, for I am with you."',
  'reference': 'Isaiah 41:10'
},
{
  'verse': '"The Lord is with you."',
  'reference': 'Judges 6:12'
},
{
  'verse': '"I will never leave you."',
  'reference': 'Hebrews 13:5'
}
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll verses every 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _autoScrollVerses();
      }
    });
  }

  void _autoScrollVerses() {
    if (_verseController.page == bibleVerses.length - 1) {
      _verseController.animateToPage(
        0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } else {
      _verseController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
    Future.delayed(const Duration(seconds: 5), _autoScrollVerses);
  }

  @override
  void dispose() {
    _verseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A), // Dark blue
              Color(0xFF3B82F6), // Medium blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/images/bible_icon.png',
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Holy Bible',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'King James Version',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 150, // Fixed height for carousel
                      child: PageView.builder(
                        controller: _verseController,
                        itemCount: bibleVerses.length,
                        itemBuilder: (context, index) {
                          final verse = bibleVerses[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  verse['verse']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  verse['reference']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SmoothPageIndicator(
                      controller: _verseController,
                      count: bibleVerses.length,
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.white,
                        dotColor: Colors.white54,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade800,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: const Text(
                        'Enter App',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Add your about screen navigation here
                      },
                      child: const Text('About this app'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}