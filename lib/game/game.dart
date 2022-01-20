import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class DinoGame extends FlameGame {
  SpriteAnimationComponent dino = SpriteAnimationComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('DinoSprites-mort.png'),
      srcSize: Vector2(24.0, 24.0),
    );

    final idleAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 3);
    final runAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);

    dino.size = Vector2(80.0, 80.0);
    dino.x = 100;
    dino.y = 100;
    dino.animation = idleAnimation;

    add(dino);
  }
}
