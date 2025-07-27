import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  final String storyId;
  final List<QuizQuestion> questions;

  Quiz({
    required this.storyId,
    required this.questions,
  });

  factory Quiz.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Quiz(
      storyId: data['storyId'] ?? '',
      questions: (data['questions'] as List<dynamic>).map((q) => QuizQuestion.fromMap(q)).toList(),
    );
  }

  static Future<List<Quiz>> fetchQuizzesForStory(String storyId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('quizzes')
      .where('storyId', isEqualTo: storyId)
      .get();
  print('Quiz docs found: ${snapshot.docs.length}');
  return snapshot.docs.map((doc) => Quiz.fromFirestore(doc)).toList();
}
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      question: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctAnswerIndex: map['correctAnswerIndex'] ?? 0,
    );
  }
}