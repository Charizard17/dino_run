import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

const double groundHeight = 32;
const double dinoTopBottomSpacing = 5;
const int numberOfTilesAlongWidth = 10;

class Dino extends SpriteAnimationComponent {
  // dino spritesheet animations
  // 0 - 3 = idle,
  // 4 - 10 = run,
  // 11 - 13 = kick,
  // 14 - 16 = hit,
  // 17 - 23 = sprint

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

    this.animation = runAnimation;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    this.height = this.width = size[0] / numberOfTilesAlongWidth;
    this.x = this.width;
    this.y = size[1] - groundHeight - this.height + dinoTopBottomSpacing;
  }
}
