// screens/story_screen.dart
import 'package:flutter/material.dart';
import '../models/story_model.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  StoryScreenState createState() => StoryScreenState();
}

class StoryScreenState extends State<StoryScreen> {
  int _currentPageIndex = 0;
  late Story _currentStory;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final storyId = ModalRoute.of(context)!.settings.arguments as String;
    _currentStory = _getStoryById(storyId);
  }

  Story _getStoryById(String id) {
    // In a real app, this would come from a database or API
    if (id == '1') {
      return Story(
        id: '1',
        title: 'The Hungry Caterpillar',
        pages: [
          StoryPage(
            text: 'In the light of the moon, a little egg lay on a leaf.',
            image: 'assets/images/thc_1.png',
          ),
          StoryPage(
            text: 'One Sunday morning, the warm sun came up and POP! Out of the egg came a tiny, very hungry caterpillar.',
            image: 'assets/images/thc_2.png',
          ),
          StoryPage(
            text: 'He started to look for some food. On Monday he ate through one apple. But he was still hungry!',
            image: 'assets/images/thc_3.png',
          ),
          StoryPage(
            text: 'On Tuesday he ate through two pears, but he was still hungry!',
            image: 'assets/images/thc_4.png',
          ),
          StoryPage(
            text: 'After eating through many foods, he built a cocoon and stayed inside for two weeks. Then he nibbled a hole and...',
            image: 'assets/images/thc_5.png',
          ),
          StoryPage(
            text: 'He emerged as a beautiful butterfly!',
            image: 'assets/images/thc_6.png',
          ),
        ],
      );
    } else if (id == '2') {
      return Story(
        id: '2',
        title: 'The Three Little Pigs',
        pages: [
          StoryPage(
            text: 'Once upon a time, there were three little pigs who left home to build their own houses.',
            image: 'assets/images/ttlp_1.png',
          ),
          StoryPage(
            text: 'The first little pig built his house with straw because it was the easiest thing to do.',
            image: 'assets/images/ttlp_2.png',
          ),
          StoryPage(
            text: 'The second little pig built his house with sticks. This was a little stronger than the straw house.',
            image: 'assets/images/ttlp_3.png',
          ),
          StoryPage(
            text: 'The third little pig built his house with bricks because he wanted a strong, safe home.',
            image: 'assets/images/ttlp_4.png',
          ),
          StoryPage(
            text: 'One day, the big bad wolf came and huffed and puffed and blew the straw house down!',
            image: 'assets/images/ttlp_5.png',
          ),
          StoryPage(
            text: 'The wolf then blew down the stick house. The two pigs ran to their brother\'s brick house.',
            image: 'assets/images/ttlp_6.png',
          ),
          StoryPage(
            text: 'The wolf couldn\'t blow down the brick house. The three little pigs lived safely ever after!',
            image: 'assets/images/ttlp_7.png',
          ),
        ],
      );
    } else {
      return Story(
        id: '3',
        title: 'The Rainbow Fish',
        pages: [
          StoryPage(
            text: 'The Rainbow Fish was the most beautiful fish in the ocean with shiny, colorful scales.',
            image: 'assets/images/trf_1.png',
          ),
          StoryPage(
            text: 'The other fish admired Rainbow Fish, but he was too proud and wouldn\'t play with them.',
            image: 'assets/images/trf_2.png',
          ),
          StoryPage(
            text: 'One day, a little blue fish asked for one of Rainbow Fish\'s shiny scales, but he refused rudely.',
            image: 'assets/images/trf_3.png',
          ),
          StoryPage(
            text: 'Soon, none of the other fish would talk to Rainbow Fish anymore. He felt very lonely.',
            image: 'assets/images/trf_4.png',
          ),
          StoryPage(
            text: 'The wise octopus told Rainbow Fish to share his scales to find happiness.',
            image: 'assets/images/trf_5.png',
          ),
          StoryPage(
            text: 'Rainbow Fish gave each fish one of his shiny scales. Soon he had only one left, but he was happy!',
            image: 'assets/images/trf_6.png',
          ),
          StoryPage(
            text: 'Now Rainbow Fish played with all the other fish and was happier than he had ever been!',
            image: 'assets/images/trf_7.png',
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentStory.title),
        actions: [
  if (_currentPageIndex == _currentStory.pages!.length - 1)
    IconButton(
      icon: Icon(Icons.quiz),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/quiz',
          arguments: _currentStory.id,
        );
      },
      tooltip: 'Take Quiz',
    ),
],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _currentStory.pages!.length,
              controller: PageController(initialPage: _currentPageIndex),
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildStoryPage(_currentStory.pages![index]);
              },
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildStoryPage(StoryPage page) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              page.image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Text(
            page.text,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _currentStory.pages!.length,
          (index) => Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPageIndex == index ? Colors.purple : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}