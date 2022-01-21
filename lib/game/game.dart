import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';

const double groundHeight = 32;
const double dinoTopBottomSpacing = 10;
const int numberOfTilesAlongWidth = 10;

class DinoGame extends FlameGame {
  SpriteAnimationComponent _dino = SpriteAnimationComponent();

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

    _dino.animation = runAnimation;

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
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    _dino.height = _dino.width = size[0] / numberOfTilesAlongWidth;
    _dino.x = _dino.width;
    _dino.y = size[1] - groundHeight - _dino.height + dinoTopBottomSpacing;
  }
}
