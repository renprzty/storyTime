import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/story_selection_screen.dart';
import 'screens/story_screen.dart';
import 'screens/games_screen.dart';
import 'screens/quiz_story_selection_screen.dart';
import 'screens/quiz_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StoryTimeApp());
}

class StoryTimeApp extends StatelessWidget {
  const StoryTimeApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story Time',
      theme: ThemeData(
        fontFamily: 'ComicNeue',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.amber),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/stories': (context) => StorySelectionScreen(),
        '/story': (context) => const StoryScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/games': (context) => const GamesScreen(),
        '/quiz-select-story': (context) => QuizStorySelectionScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}