import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../widgets/hud.dart';
import '../widgets/game_over_menu.dart';
import '../widgets/pause_menu.dart';
import '../game/dino.dart';
import '../game/dino_game.dart';

class GamePlay extends StatelessWidget {
  DinoGame dinoGame = DinoGame();
  Dino _dino = Dino();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: dinoGame,
        overlayBuilderMap: {
          'Hud': (_, DinoGame gameRef) {
            return dinoGame.buildHud();
          },
          'PauseMenu': (_, DinoGame gameRef) {
            return PauseMenu(
              onResumePressed: dinoGame.resumeGame,
            );
          },
          'GameOverMenu': (_, DinoGame gameRef) {
            return GameOverMenu(
              onRestartPressed: dinoGame.reset,
              score: dinoGame.score,
            );
          },
        },
      ),
    );
  }
}
