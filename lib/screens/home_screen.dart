// screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[100]!, Colors.amber[50]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/story_time_logo.png', height: 150),
              SizedBox(height: 30),
              Text(
                'Story Time \nAdventures',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              _buildMenuButton(context, 'Read Stories', Icons.book, '/stories'),
              _buildMenuButton(context, 'Play Games', Icons.games, '/games'),
              _buildMenuButton(
                context,
                'Take Quizzes',
                Icons.quiz,
                null, // route diisi null, karena akan custom onPressed
                onPressed: () => Navigator.pushNamed(context, '/quiz-select-story'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
  BuildContext context,
  String text,
  IconData icon,
  String? route, {
  VoidCallback? onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: ElevatedButton.icon(
      icon: Icon(icon, size: 24, color: Colors.white),
      label: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: Size(250, 50),
      ),
      onPressed: onPressed ?? () {
        if (route != null) Navigator.pushNamed(context, route);
      },
    ),
  );
}
}