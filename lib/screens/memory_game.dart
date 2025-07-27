// memory_game.dart
import 'package:flutter/material.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  MemoryGameState createState() => MemoryGameState();
}

class MemoryGameState extends State<MemoryGame> {
  List<String> cardImages = [
    'assets/images/caterpillar_card.png',
    'assets/images/butterfly_card.png',
    'assets/images/pig_card.png',
    'assets/images/wolf_card.png',
    'assets/images/fish_card.png',
    'assets/images/octopus_card.png',
  ];

  List<String> gameCards = [];
  List<bool> cardFlipped = [];
  List<bool> cardMatched = [];
  int? firstCardIndex;
  int? secondCardIndex;
  int moves = 0;
  int matches = 0;
  bool processing = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // Duplicate cards for matching
    gameCards = List.from(cardImages)..addAll(cardImages);
    gameCards.shuffle();
    
    cardFlipped = List.generate(gameCards.length, (index) => false);
    cardMatched = List.generate(gameCards.length, (index) => false);
    
    firstCardIndex = null;
    secondCardIndex = null;
    moves = 0;
    matches = 0;
  }

  void _flipCard(int index) {
    if (processing || cardFlipped[index] || cardMatched[index]) return;

    setState(() {
      cardFlipped[index] = true;
    });

    if (firstCardIndex == null) {
      firstCardIndex = index;
    } else {
      secondCardIndex = index;
      moves++;
      _checkForMatch();
    }
  }

  void _checkForMatch() {
    processing = true;

    if (gameCards[firstCardIndex!] == gameCards[secondCardIndex!]) {
      // Match found
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          cardMatched[firstCardIndex!] = true;
          cardMatched[secondCardIndex!] = true;
          firstCardIndex = null;
          secondCardIndex = null;
          matches++;
          processing = false;
        });

        if (matches == cardImages.length) {
          _showGameComplete();
        }
      });
    } else {
      // No match
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          cardFlipped[firstCardIndex!] = false;
          cardFlipped[secondCardIndex!] = false;
          firstCardIndex = null;
          secondCardIndex = null;
          processing = false;
        });
      });
    }
  }

  void _showGameComplete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You completed the game in $moves moves!'),
          actions: [
            TextButton(
              child: Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                _initializeGame();
              },
            ),
            TextButton(
              child: Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Match'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _initializeGame,
            tooltip: 'Restart Game',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Moves: $moves', style: TextStyle(fontSize: 18)),
                Text('Matches: $matches/${cardImages.length}', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: gameCards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _flipCard(index),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: cardFlipped[index] || cardMatched[index]
                        ? _buildCardFront(index)
                        : _buildCardBack(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardFront(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: cardMatched[index] ? Colors.green : Colors.purple,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          gameCards[index],
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.question_mark,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}