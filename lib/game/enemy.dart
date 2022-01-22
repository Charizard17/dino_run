import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import '../helpers/constants.dart';

class Enemy extends SpriteAnimationComponent {
  late final SpriteAnimation _walkAnimation;
  final speed = 200;
  double deviceWidth = 1000;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadAnimations().then((_) => this.animation = _walkAnimation);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('/AngryPig/Walk.png'),
      srcSize: Vector2(36.0, 30.0),
    );

    _walkAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 15);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    this.height = this.width = size[0] / numberOfTilesAlongWidth;

    this.x = size[0] + this.width;
    this.y = size[1] - groundHeight - this.height;

    deviceWidth = size[0];
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x -= speed * dt;

    if (this.x < 0) {
      this.x = deviceWidth + size[0];
    }
  }
}
