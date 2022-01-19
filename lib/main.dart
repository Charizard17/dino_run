import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
      ),
      home: const MyHomePage(title: 'Dino Run'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlameGame game;

  @override
  void initState() {
    super.initState();

    game = FlameGame();

    Future<void> asyncFunc() async {
      final sprite = await Sprite.load('DinoSprites_mort.gif');
      var dinoSprite = SpriteComponent(size: Vector2(64, 64), sprite: sprite);

      dinoSprite.x = 100;
      dinoSprite.y = 100;

      game.add(dinoSprite);
    }

    asyncFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: game),
    );
  }
}
