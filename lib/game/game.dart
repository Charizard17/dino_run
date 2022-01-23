import 'dart:ui';

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
    _scoreText = TextComponent(text: score.toString());
    add(_scoreText);

    _scoreText.x = size[0] / 2;
    _scoreText.y = 0;
  }

  @override
  bool onTapDown(TapDownInfo event) {
    _dino.jump();
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    score += (60 * dt).toInt();
    _scoreText.text = score.toString();

    final List<Enemy> _enemyList = children.whereType<Enemy>().toList();

    _enemyList.forEach((enemy) {
      if (_dino.distance(enemy) < 25) {
        print('dino hit an enemy');
        _dino.hit();
      }
    });
  }
}
