import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

import './enemy.dart';
import './game.dart';

class EnemyManager extends Component with HasGameRef<DinoGame> {
  Random _random = Random();
  late Timer _timer;
  int _spawnLevel = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _timer = Timer(4, repeat: true, onTick: () {
      spawnRandomEnemy();
    });
  }

  void spawnRandomEnemy() {
    final randomNumber = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randomNumber);
    final newEnemy = Enemy(randomEnemyType);

    gameRef.add(newEnemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void render(Canvas canvas) {}

  @override
  void update(double dt) {
    _timer.update(dt);

    var newSpawnLevel = gameRef.score ~/ 500;
    if (_spawnLevel < newSpawnLevel) {
      _spawnLevel = newSpawnLevel;

      var newWaitTime = (4 / (1 + (0.1 * _spawnLevel)));
      print(newWaitTime);

      _timer.stop();
      _timer = Timer(4, repeat: true, onTick: () {
        spawnRandomEnemy();
      });
      _timer.start();
    }
  }
}
