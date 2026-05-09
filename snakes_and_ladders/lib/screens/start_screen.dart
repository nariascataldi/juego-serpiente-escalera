import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/question.dart';
import '../models/game_config.dart';
import '../theme.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final List<TextEditingController> _nameControllers = [
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1),
              Color(0xFF8B5CF6),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildTitle(),
                const SizedBox(height: 32),
                _buildPlayerSection(context),
                const SizedBox(height: 24),
                _buildTopicSection(context),
                const SizedBox(height: 24),
                _buildDifficultySection(context),
                const SizedBox(height: 24),
                _buildWrongRuleSection(context),
                const SizedBox(height: 32),
                _buildStartButton(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        const Text(
          '🎲',
          style: TextStyle(fontSize: 60),
        ),
        const SizedBox(height: 8),
        const Text(
          'Serpientes',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Text(
          '& Escaleras',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '🧠 Aprendizaje Multitemático',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerSection(BuildContext context) {
    final game = context.watch<GameProvider>();
    final playerCount = game.players.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('👨‍👧‍👦 ', style: TextStyle(fontSize: 20)),
              Text(
                '¿Quién juega?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(
            playerCount,
            (index) => _buildPlayerInput(index),
          ),
          if (playerCount < 4)
            TextButton.icon(
              onPressed: () {
                final controller = TextEditingController();
                setState(() {
                  _nameControllers.add(controller);
                });
                game.addPlayer('');
              },
              icon: const Icon(Icons.add),
              label: const Text('+ Agregar jugador'),
            ),
        ],
      ),
    );
  }

  Widget _buildPlayerInput(int index) {
    final game = context.read<GameProvider>();
    final emojis = ['🔵', '🔴', '🟢', '🟡'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.playerColors['player${index + 1}'],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                emojis[index],
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _nameControllers[index],
              decoration: InputDecoration(
                hintText: 'Jugador ${index + 1}',
                isDense: true,
              ),
              onChanged: (value) {
                final players = game.players;
                if (index < players.length) {
                  final player = players[index];
                  game.removePlayer(index);
                  game.addPlayer(value.isEmpty ? 'Jugador ${index + 1}' : value);
                }
              },
            ),
          ),
          if (index > 0)
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () {
                setState(() {
                  _nameControllers[index].dispose();
                  _nameControllers.removeAt(index);
                });
                game.removePlayer(index);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTopicSection(BuildContext context) {
    final game = context.watch<GameProvider>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('📚 ', style: TextStyle(fontSize: 20)),
              Text(
                'Tema del Cuestionario',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: QuestionTopic.values.map((topic) {
              final isSelected = game.config.topic == topic;
              return ChoiceChip(
                label: Text('${topic.emoji} ${topic.displayName}'),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    game.updateConfig(
                      game.config.copyWith(topic: topic),
                    );
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultySection(BuildContext context) {
    final game = context.watch<GameProvider>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('📊 ', style: TextStyle(fontSize: 20)),
              Text(
                'Dificultad',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: QuestionLevel.values.map((level) {
              final isSelected = game.config.difficulty == level;
              return ChoiceChip(
                label: Text('${level.emoji} ${level.displayName}'),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    game.updateConfig(
                      game.config.copyWith(difficulty: level),
                    );
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWrongRuleSection(BuildContext context) {
    final game = context.watch<GameProvider>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('❌ ', style: TextStyle(fontSize: 20)),
              Text(
                'Si responde mal...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: WrongRule.values.map((rule) {
              final isSelected = game.config.wrongRule == rule;
              return ChoiceChip(
                label: Text('${rule.emoji} ${rule.displayName}'),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    game.updateConfig(
                      game.config.copyWith(wrongRule: rule),
                    );
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<GameProvider>().startGame();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🎮 '),
            Text('¡Comenzar Juego!'),
          ],
        ),
      ),
    );
  }
}