import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';
import '../../theme.dart';

class EventModal extends StatelessWidget {
  const EventModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        if (game.gameState != GameState.event || game.currentPlayer == null) {
          return const SizedBox.shrink();
        }

        final pendingEvent = _getPendingEvent(game);
        if (pendingEvent == null) return const SizedBox.shrink();

        final isLadder = pendingEvent.isLadder;
        final player = game.currentPlayer!;
        final from = pendingEvent.from;
        final to = pendingEvent.to;

        return Container(
          color: Colors.black54,
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(32),
              padding: const EdgeInsets.all(32),
              decoration: AppTheme.glassCard,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isLadder ? '🪜' : '🐍',
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isLadder ? '¡Escalera!' : '¡Serpiente!',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${player.name} ${isLadder ? 'sube' : 'baja'} del casillero $from al $to',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => game.closeEventModal(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('¡Entendido!'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PendingEvent? _getPendingEvent(GameProvider game) {
    final player = game.currentPlayer;
    if (player == null) return null;

    final pos = player.position;
    if (pos == 4 || pos == 9 || pos == 21 || pos == 28 || pos == 36 ||
        pos == 51 || pos == 71 || pos == 80) {
      final dest = _getLadderDest(pos);
      if (dest != null) {
        return PendingEvent(from: pos, to: dest, isLadder: true);
      }
    }
    if (pos == 17 || pos == 54 || pos == 62 || pos == 64 ||
        pos == 87 || pos == 93 || pos == 95 || pos == 99) {
      final dest = _getSnakeDest(pos);
      if (dest != null) {
        return PendingEvent(from: pos, to: dest, isLadder: false);
      }
    }
    return null;
  }

  int? _getLadderDest(int pos) {
    const ladders = {4: 14, 9: 31, 21: 42, 28: 84, 36: 44, 51: 67, 71: 91, 80: 100};
    return ladders[pos];
  }

  int? _getSnakeDest(int pos) {
    const snakes = {17: 7, 54: 34, 62: 19, 64: 60, 87: 24, 93: 73, 95: 75, 99: 78};
    return snakes[pos];
  }
}