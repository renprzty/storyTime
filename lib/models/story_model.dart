// models/story_model.dart
class Story {
  final String id;
  final String title;
  final String? coverImage;
  final String? description;
  final String? ageRange;
  final List<StoryPage>? pages;

  Story({
    required this.id,
    required this.title,
    this.coverImage,
    this.description,
    this.ageRange,
    this.pages,
  });
}

class StoryPage {
  final String text;
  final String image;

  StoryPage({
    required this.text,
    required this.image,
  });
}