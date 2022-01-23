import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import './game.dart';
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
  late EnemyType _randomEnemyType;
  EnemyData? _enemyData;

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

  Enemy(EnemyType randomEnemyType) {
    _randomEnemyType = randomEnemyType;
    _enemyData = _enemyDetails[_randomEnemyType];
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _loadAnimations().then((_) => this.animation = _walkAnimation);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(_enemyData!.imageName),
      srcSize: Vector2(_enemyData!.textureWidth, _enemyData!.textureHeight),
    );
    _walkAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 0, to: (_enemyData!.spriteCount - 1));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    textureWidth = _enemyData!.textureWidth;
    textureHeight = _enemyData!.textureHeight;

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
  }

  @override
  bool destroy() {
    return (this.x < (-this.width));
  }
}
