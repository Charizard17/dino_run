import 'package:flutter/material.dart';

import '../screens/game_play.dart';

class Menu extends StatelessWidget {
  final Function onSettingsPressed;

  const Menu({
    Key? key,
    required this.onSettingsPressed,
  })  : assert(onSettingsPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Dino Run',
          style: TextStyle(
            fontSize: 75,
            color: Theme.of(context).accentColor,
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Play',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[200],
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => GamePlay(),
              ),
            );
          },
        ),
        SizedBox(height: 10),
        TextButton.icon(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
            size: 30,
          ),
          label: Text(
            'Settings',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          onPressed: onSettingsPressed(),
        )
      ],
    );
  }
}
