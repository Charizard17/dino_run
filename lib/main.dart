import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import './game/game.dart';

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
        primarySwatch: Colors.blue,
        fontFamily: 'Digital7',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DinoGame dinoGame = DinoGame();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: dinoGame,
        overlayBuilderMap: {
          'Hud': (_, DinoGame gameRef) {
            return dinoGame.PauseOverlay();
          },
          'PauseMenu': (_, DinoGame gameRef) {
            return dinoGame.PauseMenu();
          },
        },
      ),
    );
  }
}
