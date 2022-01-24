import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/dino_game.dart';
import './screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino Run',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        accentColor: Colors.white,
        fontFamily: 'Digital7',
      ),
      home: const MainMenu(),
    );
  }
}
