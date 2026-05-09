import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../theme.dart';

class DiceWidget extends StatelessWidget {
  const DiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        final isRolling = game.gameState == GameState.rolling;
        
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: AppTheme.primaryColor,
                  width: 3,
                ),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: Text(
                    _getDiceEmoji(game.diceValue, isRolling),
                    key: ValueKey('${game.diceValue}-$isRolling'),
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: game.gameState == GameState.idle
                  ? () => game.rollDice()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🎲 '),
                  Text('Tirar Dado'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _getDiceEmoji(int value, bool isRolling) {
    if (isRolling || value == 0) {
      final emojis = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];
      return emojis[Random().nextInt(6)];
    }
    final emojis = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];
    return emojis[value - 1];
  }
}