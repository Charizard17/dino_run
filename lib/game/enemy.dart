import 'dart:ui';

import 'package:dino_run/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import '../helpers/constants.dart';

enum EnemyType { AngryPig, Bat, Rino }

class EnemyData {
  final String imageName;
  final double textureWidth;
  final double textureHeight;
  final int spriteCount;

  EnemyData({
    required this.imageName,
    required this.textureWidth,
    required this.textureHeight,
    required this.spriteCount,
  });
}

class Enemy extends SpriteAnimationComponent {
  late final SpriteAnimation _walkAnimation;
  final speed = 200;
  double deviceWidth = 1000;
  double textureWidth = 50;
  double textureHeight = 50;

  static Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.AngryPig: EnemyData(
      imageName: '/AngryPig/Walk.png',
      spriteCount: 15,
      textureWidth: 36.0,
      textureHeight: 30.0,
    ),
    EnemyType.Bat: EnemyData(
      imageName: '/Bat/Flying.png',
      spriteCount: 7,
      textureWidth: 46.0,
      textureHeight: 30.0,
    ),
    EnemyType.Rino: EnemyData(
      imageName: '/Rino/Run.png',
      spriteCount: 6,
      textureWidth: 52.0,
      textureHeight: 34.0,
    ),
  };

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _loadAnimations().then((_) => this.animation = _walkAnimation);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(_enemyDetails[EnemyType.Rino]!.imageName),
      srcSize: Vector2(_enemyDetails[EnemyType.Rino]!.textureWidth,
          _enemyDetails[EnemyType.Rino]!.textureHeight),
    );
    _walkAnimation = spriteSheet.createAnimation(
        row: 0,
        stepTime: 0.1,
        from: 0,
        to: (_enemyDetails[EnemyType.Rino]!.spriteCount - 1));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    textureWidth = _enemyDetails[EnemyType.Rino]!.textureWidth;
    textureHeight = _enemyDetails[EnemyType.Rino]!.textureHeight;

    double scaleFactor = (size[0] / numberOfTilesAlongWidth) / textureWidth;

    this.height = textureHeight * scaleFactor;
    this.width = textureWidth * scaleFactor;

    this.x = size[0] + this.width;
    this.y = size[1] - groundHeight - this.height;

    deviceWidth = size[0];
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x -= speed * dt;

    if (this.x < -size[0]) {
      this.x = deviceWidth + size[0];
    }
  }
}
