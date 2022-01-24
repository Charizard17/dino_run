import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'dino_game.dart';
import '../helpers/constants.dart';

enum EnemyType { AngryPig, Bat, Rino }

class EnemyData {
  final String imageName;
  final double textureWidth;
  final double textureHeight;
  final int spriteCount;
  final bool canFly;
  final int speed;

  EnemyData({
    required this.imageName,
    required this.textureWidth,
    required this.textureHeight,
    required this.spriteCount,
    required this.canFly,
    required this.speed,
  });
}

class Enemy extends SpriteAnimationComponent {
  double deviceWidth = 1000;
  EnemyData? _enemyData;
  late EnemyType _randomEnemyType;
  late final SpriteAnimation _enemyAnimation;
  static Random _random = Random();

  static Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.AngryPig: EnemyData(
      imageName: '/AngryPig/Walk.png',
      spriteCount: 15,
      textureWidth: 36.0,
      textureHeight: 30.0,
      canFly: false,
      speed: 250,
    ),
    EnemyType.Bat: EnemyData(
      imageName: '/Bat/Flying.png',
      spriteCount: 7,
      textureWidth: 46.0,
      textureHeight: 30.0,
      canFly: true,
      speed: 300,
    ),
    EnemyType.Rino: EnemyData(
      imageName: '/Rino/Run.png',
      spriteCount: 6,
      textureWidth: 52.0,
      textureHeight: 34.0,
      canFly: false,
      speed: 350,
    ),
  };

  Enemy(EnemyType randomEnemyType) {
    _randomEnemyType = randomEnemyType;
    _enemyData = _enemyDetails[_randomEnemyType];
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _loadAnimations().then((_) => this.animation = _enemyAnimation);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(_enemyData!.imageName),
      srcSize: Vector2(_enemyData!.textureWidth, _enemyData!.textureHeight),
    );

    this.anchor = Anchor.center;

    _enemyAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 0, to: (_enemyData!.spriteCount - 1));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    deviceWidth = size[0];

    double scaleFactor =
        (size[0] / numberOfTilesAlongWidth) / _enemyData!.textureWidth;

    this.height = _enemyData!.textureHeight * scaleFactor;
    this.width = _enemyData!.textureWidth * scaleFactor;

    this.x = size[0] + this.width;
    this.y = size[1] - groundHeight - (this.height / 2);

    if (_enemyData!.canFly && _random.nextBool()) {
      this.y -= this.height;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x -= _enemyData!.speed * dt;
  }

  @override
  bool destroy() {
    return (this.x < (-this.width));
  }
}
