import 'package:flutter/material.dart';

import './game_play.dart';
import '../widgets/menu.dart';
import '../widgets/settings.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late CrossFadeState _crossFadeState;

  @override
  void initState() {
    super.initState();
    _crossFadeState = CrossFadeState.showFirst;
  }

  void showMenu() {
    _crossFadeState = CrossFadeState.showFirst;
  }

  void showSettings() {
    _crossFadeState = CrossFadeState.showSecond;
  }

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
                firstChild: Menu(
                  onSettingsPressed: showSettings,
                ),
                secondChild: Settings(
                  onBackButtonPressed: showMenu,
                ),
                crossFadeState: _crossFadeState,
                duration: Duration(milliseconds: 300),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
