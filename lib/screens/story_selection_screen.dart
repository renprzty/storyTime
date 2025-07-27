// screens/story_selection_screen.dart
import 'package:flutter/material.dart';
import '../models/story_model.dart';

class StorySelectionScreen extends StatelessWidget {
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

  StorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Story'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return _buildStoryCard(context, stories[index]);
        },
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context, Story story) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/story',
            arguments: story.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  story.coverImage!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      story.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.child_care, size: 16, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(
                          story.ageRange!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}