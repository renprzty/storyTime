import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseService {
  final String baseUrl = 'http://10.0.2.2:8000'; // Ganti dengan alamat API Anda

  // Ambil semua cerita
  Future<List<Map<String, dynamic>>> fetchStories() async {
    final response = await http
        .get(Uri.parse('$baseUrl/stories.php'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Invalid stories data format');
      }
    } else {
      throw Exception('Failed to load stories');
    }
  }

  // Ambil quiz berdasarkan storyId
  Future<List<Map<String, dynamic>>> fetchQuizzes(String storyId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/quizzes.php?storyId=$storyId'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Invalid quizzes data format');
      }
    } else {
      throw Exception('Failed to load quizzes');
    }
  }

  // Tambah cerita baru
  Future<bool> addStory(Map<String, dynamic> storyData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_story.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(storyData),
    ).timeout(const Duration(seconds: 10));
    return response.statusCode == 200;
  }

  // Tambah quiz baru
  Future<bool> addQuiz(Map<String, dynamic> quizData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_quiz.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(quizData),
    ).timeout(const Duration(seconds: 10));
    return response.statusCode == 200;
  }

  // Update cerita
  Future<bool> updateStory(String storyId, Map<String, dynamic> storyData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update_story.php?storyId=$storyId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(storyData),
    ).timeout(const Duration(seconds: 10));
    return response.statusCode == 200;
  }

  // Update quiz
  Future<bool> updateQuiz(String quizId, Map<String, dynamic> quizData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update_quiz.php?quizId=$quizId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(quizData),
    ).timeout(const Duration(seconds: 10));
    return response.statusCode == 200;
  }

  // Hapus cerita
  Future<bool> deleteStory(String storyId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete_story.php?storyId=$storyId'),
    ).timeout(const Duration(seconds: 10));
    return response.statusCode == 200;
  }

  // Hapus quiz
  Future<bool> deleteQuiz(String quizId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete_quiz.php?quizId=$quizId'),
    ).timeout(const Duration(seconds: 10));
    return response.statusCode == 200;
  }
}