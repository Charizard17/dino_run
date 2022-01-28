import 'dart:ui';
import 'dart:ui' hide TextStyle;

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import './dino.dart';
import './audio_manager.dart';
import './enemy_manager.dart';
import './enemy.dart';

class DinoGame extends FlameGame with TapDetector {
  Dino _dino = Dino();
  TextComponent _scoreText = TextComponent();
  double _elapsedTime = 0.0;
  late int score;
  late EnemyManager _enemyManager;

  bool _isGameOver = false;
  bool _isGamePaused = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    FlameAudio.bgm.stop();

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

    AudioManager.instance.startBgm('knight_online_soundtrack.mp3');
  }

  @override
  bool onTapDown(TapDownInfo event) {
    super.onTapDown(event);
    if (!_isGameOver && !_isGamePaused) {
      _dino.jump();
      return true;
    }
    return false;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _elapsedTime += dt;
    if (_elapsedTime > (1 / 60)) {
      _elapsedTime = 0.0;
      score += 1;
      _scoreText.text = score.toString();
    }

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

    if (!_isGameOver) {
      overlays.add('PauseMenu');
      overlays.remove('Hud');

      _isGamePaused = true;
    }

    AudioManager.instance.pauseBgm();
  }

  void resumeGame() {
    overlays.add('Hud');
    overlays.remove('PauseMenu');
    resumeEngine();

    _isGamePaused = false;

    AudioManager.instance.resumeBgm();
  }

  void gameOver() {
    pauseEngine();
    overlays.add('GameOverMenu');

    _isGameOver = true;

    AudioManager.instance.pauseBgm();
  }

  void reset() {
    this.score = 0;
    _dino.life.value = 5;
    _enemyManager.reset();
    _dino.run();
    children.whereType<Enemy>().forEach((enemy) {
      this.remove(enemy);
    });

    overlays.remove('GameOverMenu');

    _isGameOver = false;

    resumeEngine();
    AudioManager.instance.pauseBgm();
  }

  @override
  void onDetach() {
    super.onDetach();
    AudioManager.instance.stopBgm();
  }

  //////////////////
  /// build hud widget removed from game_play,
  /// because dino life hearts wasn't working correctly
  /// this is just a solution for this issue
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
}
