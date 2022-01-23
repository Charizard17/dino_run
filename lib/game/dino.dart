import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import '../helpers/constants.dart';

class Dino extends SpriteAnimationComponent {
  // dino spritesheet animations
  // 0 - 3 = idle,
  // 4 - 10 = run,
  // 11 - 13 = kick,
  // 14 - 16 = hit,
  // 17 - 23 = sprint

  double speedY = 0.0;
  double yMax = 0.0;
  late Timer _timer;
  bool _isHit = false;

  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _hitAnimation;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadAnimations().then((_) => this.animation = _runAnimation);

    _timer = Timer(1, onTick: () {
      run();
    });
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

    _timer.update(dt);
  }

  bool isOnGround() {
    return (this.y >= this.yMax);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('DinoSprites-mort.png'),
      srcSize: Vector2(24.0, 24.0),
    );

    this.anchor = Anchor.center;

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

    this.y = size[1] - groundHeight - (this.height / 2) + dinoTopBottomSpacing;
    this.yMax = this.y;
  }

  void run() {
    _isHit = false;
    this.animation = _runAnimation;
  }

  void hit() {
    if (!_isHit) {
      this.animation = _hitAnimation;
      _timer.start();
      _isHit = true;
    }
  }

  void jump() {
    if (isOnGround()) {
      this.speedY = -500;
    }
  }
}
