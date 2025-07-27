// drag_drop_game.dart
import 'package:flutter/material.dart';

class DragDropGame extends StatefulWidget {
  const DragDropGame({super.key});

  @override
  DragDropGameState createState() => DragDropGameState();
}

class DragDropGameState extends State<DragDropGame> {
  List<Character> characters = [
    Character('Caterpillar', 'assets/images/caterpillar_card.png', 'The Hungry Caterpillar'),
    Character('Butterfly', 'assets/images/butterfly_card.png', 'The Hungry Caterpillar'),
    Character('Pig', 'assets/images/pig_card.png', 'The Three Little Pigs'),
    Character('Wolf', 'assets/images/wolf_card.png', 'The Three Little Pigs'),
    Character('Rainbow Fish', 'assets/images/fish_card.png', 'The Rainbow Fish'),
    Character('Octopus', 'assets/images/octopus_card.png', 'The Rainbow Fish'),
  ];

  List<Character> droppedCharacters = [];
  int correctDrops = 0;
  bool gameCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character Sort'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Drag characters to their stories!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  // Characters to drag
                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: characters
                          .where((char) => !droppedCharacters.contains(char))
                          .map((char) => Draggable<Character>(
                                data: char,
                                feedback: _buildCharacterCard(char, true),
                                childWhenDragging: Opacity(
                                  opacity: 0.5,
                                  child: _buildCharacterCard(char, false),
                                ),
                                child: _buildCharacterCard(char, false),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Drop targets
                  Expanded(
                    child: Column(
                      children: [
                        _buildStoryDropTarget('The Hungry Caterpillar'),
                        SizedBox(height: 20),
                        _buildStoryDropTarget('The Three Little Pigs'),
                        SizedBox(height: 20),
                        _buildStoryDropTarget('The Rainbow Fish'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (gameCompleted) _buildCompletionMessage(),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterCard(Character character, bool isDragging) {
    return Material(
      elevation: isDragging ? 8 : 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              character.imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8),
            Text(
              character.name,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryDropTarget(String storyTitle) {
    return DragTarget<Character>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.purple,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                storyTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: droppedCharacters
                    .where((char) => char.story == storyTitle)
                    .map((char) => _buildDroppedCharacter(char))
                    .toList(),
              ),
            ],
          ),
        );
      },
      onWillAcceptWithDetails: (details) => details.data.story == storyTitle,
      onAcceptWithDetails: (details) {
  setState(() {
    droppedCharacters.add(details.data);
    correctDrops++;
    if (correctDrops == characters.length) {
      gameCompleted = true;
    }
  });
},
    );
  }

  Widget _buildDroppedCharacter(Character character) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 60,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              character.imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 4),
            Text(
              character.name,
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionMessage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Great Job!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text('Play Again'),
            onPressed: () {
              setState(() {
                droppedCharacters.clear();
                correctDrops = 0;
                gameCompleted = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

class Character {
  final String name;
  final String imagePath;
  final String story;

  Character(this.name, this.imagePath, this.story);
}