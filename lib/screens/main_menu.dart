import 'package:flutter/material.dart';

import './game_play.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            color: Colors.black.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 70,
                vertical: 50,
              ),
              child: AnimatedCrossFade(
                crossFadeState: _crossFadeState,
                duration: Duration(milliseconds: 300),
                firstChild: Menu(),
                secondChild: Settings(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Menu() {
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
          onPressed: () {
            _crossFadeState = CrossFadeState.showSecond;
            setState(() {});
          },
        )
      ],
    );
  }

  Widget Settings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 50,
            color: Theme.of(context).accentColor,
          ),
        ),
        SizedBox(height: 20),
        SwitchListTile(
          value: true,
          title: Text(
            'Sound effects',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          onChanged: (bool value) {},
        ),
        SwitchListTile(
          value: true,
          title: Text(
            'Background music',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          onChanged: (bool value) {},
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            _crossFadeState = CrossFadeState.showFirst;
            setState(() {});
          },
        ),
      ],
    );
  }
}
