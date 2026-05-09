import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/board_widget.dart';
import '../widgets/dice_widget.dart';
import 'modals/question_modal.dart';
import 'modals/event_modal.dart';
import 'modals/win_modal.dart';
import 'modals/rules_modal.dart';
import '../theme.dart';

class GameScreenWidget extends StatefulWidget {
  const GameScreenWidget({super.key});

  @override
  State<GameScreenWidget> createState() => _GameScreenWidgetState();
}

class _GameScreenWidgetState extends State<GameScreenWidget> {
  bool _showRules = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildHeader(context, game),
                    Expanded(
                      child: _buildMainContent(game),
                    ),
                  ],
                ),
                const QuestionModal(),
                const EventModal(),
                const WinModal(),
                RulesModal(
                  isVisible: _showRules,
                  onClose: () => setState(() => _showRules = false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, GameProvider game) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showPlayerPanel(context, game),
          ),
          const Expanded(
            child: Text(
              '🎲 Serpientes & Escaleras',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.article_outlined),
            onPressed: () => setState(() => _showRules = true),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => game.restartGame(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(GameProvider game) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTurnIndicator(game),
          const SizedBox(height: 16),
          const BoardWidget(),
          const SizedBox(height: 16),
          const DiceWidget(),
          const SizedBox(height: 16),
          _buildLog(game),
        ],
      ),
    );
  }

  Widget _buildTurnIndicator(GameProvider game) {
    final currentPlayer = game.currentPlayer;
    if (currentPlayer == null) return const SizedBox.shrink();

    final color = AppTheme.playerColors[currentPlayer.color] ?? Colors.blue;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassCard,
      child: Row(
        children: [
          Text(
            '🎯 Turno de:',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color),
            ),
            child: Text(
              '${currentPlayer.emoji} ${currentPlayer.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLog(GameProvider game) {
    if (game.logs.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.glassCard,
      constraints: const BoxConstraints(maxHeight: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📝 ', style: TextStyle(fontSize: 16)),
              Text(
                'Registro',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: game.logs.length,
              itemBuilder: (context, index) {
                final log = game.logs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    log.message,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPlayerPanel(BuildContext context, GameProvider game) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text('👥 ', style: TextStyle(fontSize: 20)),
                Text(
                  'Jugadores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...game.players.asMap().entries.map((entry) {
              final index = entry.key;
              final player = entry.value;
              final isActive = index == game.currentPlayerIndex;
              final color = AppTheme.playerColors[player.color] ?? Colors.blue;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isActive ? color.withValues(alpha: 0.1) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: isActive ? Border.all(color: color, width: 2) : null,
                ),
                child: Row(
                  children: [
                    Text(player.emoji, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isActive ? color : null,
                            ),
                          ),
                          Text(
                            '📍 ${player.position == 0 ? 'Inicio' : player.position}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '✅ ${player.correctAnswers}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          '❌ ${player.wrongAnswers}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const Divider(),
            const Text(
              '📋 Leyenda',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 16,
              children: [
                Text('🪜 Escalera (sube)'),
                Text('🐍 Serpiente (baja)'),
                Text('❓ Pregunta'),
                Text('⭐ Casilla libre'),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}