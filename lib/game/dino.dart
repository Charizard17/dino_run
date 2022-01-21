import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class Dino extends SpriteAnimationComponent {
  // dino spritesheet animations
  // 0 - 3 = idle,
  // 4 - 10 = run,
  // 11 - 13 = kick,
  // 14 - 16 = hit,
  // 17 - 23 = sprint

  final double groundHeight = 32;
  final double dinoTopBottomSpacing = 5;
  final int numberOfTilesAlongWidth = 10;
  double speedY = 0.0;
  double yMax = 0.0;
  final double GRAVITY = 1000;

  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _hitAnimation;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadAnimations().then((_) => this.animation = _runAnimation);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // v = u + a * t
    this.speedY += GRAVITY * dt;

    // d = s0 + s * t
    this.y += this.speedY * dt;

    if (isOnGround()) {
      this.y = this.yMax;
      this.speedY = 0.0;
    }
  }

  bool isOnGround() {
    return (this.y >= this.yMax);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('DinoSprites-mort.png'),
      srcSize: Vector2(24.0, 24.0),
    );

    _runAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);
    _hitAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 14, to: 16);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    this.height = this.width = size[0] / numberOfTilesAlongWidth;
    this.x = this.width;

    this.y = size[1] - groundHeight - this.height + dinoTopBottomSpacing;
    this.yMax = this.y;
  }

  void run() {
    this.animation = _runAnimation;
  }

  void hit() {
    this.animation = _hitAnimation;
  }

  void jump() {
    if (isOnGround()) {
      this.speedY = -600;
    }
  }
}
