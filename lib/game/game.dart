import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import './dino.dart';
import './enemy.dart';

class DinoGame extends FlameGame with TapDetector {
  Dino _dino = Dino();
  Enemy _enemy = Enemy();

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
    add(_enemy);
  }

  @override
  bool onTapDown(TapDownInfo event) {
    _dino.jump();
    return true;
  }
}
