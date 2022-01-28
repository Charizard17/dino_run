import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import './game/dino_game.dart';
import './screens/main_menu.dart';
import './game/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  await Flame.device.setLandscape();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await AudioManager.instance
      .init(['knight_online_soundtrack.mp3', 'hurt.wav', 'jump.wav']);
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
