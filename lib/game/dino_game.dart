import 'dart:ui';
import 'dart:ui' hide TextStyle;

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import './dino.dart';
import './enemy_manager.dart';
import './enemy.dart';

class DinoGame extends FlameGame with TapDetector {
  Dino _dino = Dino();
  TextComponent _scoreText = TextComponent();
  late int score;
  late EnemyManager _enemyManager;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/plx-1.png'),
        ParallaxImageData('parallax/plx-2.png'),
        ParallaxImageData('parallax/plx-3.png'),
        ParallaxImageData('parallax/plx-4.png'),
        ParallaxImageData('parallax/plx-5.png'),
        ParallaxImageData('parallax/plx-6.png'),
      ],
      baseVelocity: Vector2(80, 0),
      velocityMultiplierDelta: Vector2(1.1, 0),
    );

    add(parallaxComponent);

    add(_dino);

    _enemyManager = EnemyManager();
    add(_enemyManager);

    score = 0;
    final style = TextStyle(
      fontFamily: 'Digital7',
      fontSize: 40,
      color: Colors.white,
    );
    final regular = TextPaint(style: style);
    _scoreText = TextComponent(text: score.toString(), textRenderer: regular);
    _scoreText.x = size[0] / 2;
    _scoreText.y = 5;
    add(_scoreText);

    overlays.add('Hud');
  }

  @override
  bool onTapDown(TapDownInfo event) {
    _dino.jump();
    return true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    score += (60 * dt).toInt();
    _scoreText.text = score.toString();

    final List<Enemy> _enemyList = children.whereType<Enemy>().toList();

    _enemyList.forEach((enemy) {
      if (_dino.distance(enemy) < 30) {
        _dino.hit();
      }
    });

    if (_dino.life.value <= 0) {
      gameOver();
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    super.lifecycleStateChange(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        this.pauseGame();
        break;
      case AppLifecycleState.paused:
        this.pauseGame();
        break;
      case AppLifecycleState.detached:
        this.pauseGame();
        break;
    }
  }

  void pauseGame() {
    pauseEngine();
    overlays.add('PauseMenu');
    overlays.remove('Hud');
  }

  void resumeGame() {
    overlays.add('Hud');
    overlays.remove('PauseMenu');
    resumeEngine();
  }

  void gameOver() {
    pauseEngine();
    overlays.add('GameOverMenu');
  }

  void reset() {
    this.score = 0;
    _dino.life.value = 5;
    _enemyManager.reset();
    _dino.run();
    children.whereType<Enemy>().forEach((enemy) {
      this.remove(enemy);
    });
  }

  Widget buildHud() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.pause, size: 30, color: Colors.white),
            onPressed: () {
              pauseGame();
            },
          ),
          ValueListenableBuilder(
            valueListenable: _dino.life,
            builder: (context, int value, child) {
              final list = <Widget>[];
              for (int i = 0; i < 5; ++i) {
                list.add(
                  Icon(
                    (i < value) ? Icons.favorite : Icons.favorite_border,
                    color: Colors.deepOrangeAccent,
                  ),
                );
              }
              return Row(
                children: list,
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildPauseMenu() {
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
                'Paused',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(height: 10),
              IconButton(
                icon: Icon(Icons.play_arrow,
                    size: 30, color: Colors.deepOrangeAccent),
                onPressed: () {
                  resumeGame();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGameOverMenu() {
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
                'Game Over !',
                style: TextStyle(fontSize: 30, color: Colors.deepOrangeAccent),
              ),
              SizedBox(height: 10),
              Text(
                'Final score: $score',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(height: 20),
              TextButton.icon(
                icon: Icon(
                  Icons.replay,
                  color: Colors.deepOrangeAccent,
                  size: 30,
                ),
                label: Text(
                  'Play Again',
                  style:
                      TextStyle(fontSize: 30, color: Colors.deepOrangeAccent),
                ),
                onPressed: () {
                  reset();
                  overlays.remove('GameOverMenu');
                  resumeEngine();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
