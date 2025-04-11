import 'dart:convert';
import 'package:http/http.dart' as http;

class BibleApiService {
  // Fetch the verses for a specific chapter and book
  Future<List<Map<String, dynamic>>> fetchChapter(String book, int chapter) async {
    final url = 'https://bible-api.com/$book+$chapter?translation=kjv';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['verses']);
    } else {
      throw Exception('Failed to load chapter');
    }
  }
}
