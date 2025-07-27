import 'package:flutter/material.dart';
import '../models/story_model.dart'; // pastikan path model sesuai

class QuizStorySelectionScreen extends StatelessWidget {
  QuizStorySelectionScreen({super.key});

  final List<Story> stories = [
    Story(
      id: '1',
      title: 'The Hungry Caterpillar',
      coverImage: 'assets/images/thc_cover.png',
      description: 'Follow the journey of a little caterpillar as it eats its way through various foods before transforming into a beautiful butterfly.',
      ageRange: '3-5 years',
    ),
    Story(
      id: '2',
      title: 'The Three Little Pigs',
      coverImage: 'assets/images/ttlp_cover.png',
      description: 'The classic tale of three pig brothers who build houses of different materials and encounter the big bad wolf.',
      ageRange: '4-7 years',
    ),
    Story(
      id: '3',
      title: 'The Rainbow Fish',
      coverImage: 'assets/images/trf_cover.png',
      description: 'A beautiful fish learns the value of sharing and friendship in this colorful underwater adventure.',
      ageRange: '3-6 years',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Cerita untuk Quiz')),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return ListTile(
            leading: story.coverImage != null
                ? Image.asset(story.coverImage!, width: 50, height: 50)
                : null,
            title: Text(story.title),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/quiz',
                arguments: story.id,
              );
            },
          );
        },
      ),
    );
  }
}