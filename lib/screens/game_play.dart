import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../game/dino_game.dart';

class GamePlay extends StatelessWidget {
  DinoGame dinoGame = DinoGame();

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
            return dinoGame.buildPauseMenu();
          },
          'GameOverMenu': (_, DinoGame gameRef) {
            return dinoGame.buildGameOverMenu();
          },
        },
      ),
    );
  }
}
