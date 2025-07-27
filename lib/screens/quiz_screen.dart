import 'package:flutter/material.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  late List<QuizQuestion> _questions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    final storyId = (args is String && args.isNotEmpty) ? args : '1';
    _questions = _getQuestionsForStory(storyId);
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No quiz found for this story.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
            ),
            const SizedBox(height: 20),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              _questions[_currentQuestionIndex].question,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _questions[_currentQuestionIndex].options.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[100],
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _questions[_currentQuestionIndex].options[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () => _answerQuestion(
                          index, _questions[_currentQuestionIndex]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $_score',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _answerQuestion(int selectedIndex, QuizQuestion question) {
    if (selectedIndex == question.correctAnswerIndex) {
      setState(() {
        _score++;
      });
    }

    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResults();
      }
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Complete!'),
          content: Text(
              'You scored $_score!\n\n${_getResultMessage()}'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _getResultMessage() {
    final total = (_currentQuestionIndex + 1);
    double percentage = total > 0 ? _score / total : 0;
    if (percentage >= 0.8) {
      return 'Excellent! You really paid attention to the story!';
    } else if (percentage >= 0.5) {
      return 'Good job! You remembered most of the story!';
    } else {
      return 'Nice try! Maybe read the story again?';
    }
  }

  List<QuizQuestion> _getQuestionsForStory(String storyId) {
    if (storyId == '1') {
      return [
        QuizQuestion(
          question: 'What came out of the little egg?',
          options: ['A butterfly', 'A caterpillar', 'A bird', 'A worm'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What did the caterpillar eat on Monday?',
          options: ['Two pears', 'One apple', 'Three plums', 'Five oranges'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What did the caterpillar become at the end?',
          options: ['A frog', 'A butterfly', 'A bird', 'A moth'],
          correctAnswerIndex: 1,
        ),
      ];
    } else if (storyId == '2') {
      return [
        QuizQuestion(
          question: 'What did the first little pig build his house with?',
          options: ['Sticks', 'Straw', 'Bricks', 'Wood'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Which house did the wolf NOT blow down?',
          options: ['Straw house', 'Stick house', 'Brick house', 'All houses'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'How many little pigs were there?',
          options: ['Two', 'Three', 'Four', 'Five'],
          correctAnswerIndex: 1,
        ),
      ];
    } else {
      return [
        QuizQuestion(
          question: 'Why was the Rainbow Fish special?',
          options: [
            'He was the biggest',
            'He had shiny scales',
            'He could swim fastest',
            'He was the oldest'
          ],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What did the little blue fish ask for?',
          options: [
            'To play together',
            'A shiny scale',
            'Some food',
            'A place to hide'
          ],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'How did Rainbow Fish become happy?',
          options: [
            'By keeping all his scales',
            'By sharing his scales',
            'By finding more scales',
            'By swimming away'
          ],
          correctAnswerIndex: 1,
        ),
      ];
    }
  }
}