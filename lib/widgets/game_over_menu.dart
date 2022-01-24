import 'package:flutter/material.dart';

import '../screens/main_menu.dart';

class GameOverMenu extends StatelessWidget {
  final Function onRestartPressed;
  final int score;

  const GameOverMenu(
      {Key? key, required this.onRestartPressed, required this.score})
      : assert(onRestartPressed != null),
        assert(score != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 70.0,
            vertical: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Game Over',
                style: TextStyle(fontSize: 40, color: Colors.deepOrangeAccent),
              ),
              SizedBox(height: 10),
              Text(
                'Final score: $score',
                style: TextStyle(fontSize: 30, color: Colors.deepOrangeAccent),
              ),
              SizedBox(height: 15),
              TextButton.icon(
                icon: Icon(
                  Icons.replay,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text(
                  'Play Again',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                onPressed: () {
                  onRestartPressed();
                },
              ),
              SizedBox(height: 5),
              TextButton.icon(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text(
                  'Main Menu',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => MainMenu(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
