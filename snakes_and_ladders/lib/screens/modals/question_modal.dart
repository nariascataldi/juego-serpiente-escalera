import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';
import '../../models/question.dart';
import '../../theme.dart';

class QuestionModal extends StatefulWidget {
  const QuestionModal({super.key});

  @override
  State<QuestionModal> createState() => _QuestionModalState();
}

class _QuestionModalState extends State<QuestionModal> {
  bool _showHint = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        if (game.gameState != GameState.answering ||
            game.currentQuestion == null) {
          return const SizedBox.shrink();
        }

        final question = game.currentQuestion!;
        final cellNumber = game.currentQuestionCell ?? 0;
        final level = QuestionLevel.values.firstWhere(
          (l) => l.name == question.level,
          orElse: () => QuestionLevel.medium,
        );

        return Container(
          color: Colors.black54,
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: AppTheme.glassCard,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: level == QuestionLevel.easy
                              ? Colors.green.shade100
                              : level == QuestionLevel.medium
                                  ? Colors.yellow.shade100
                                  : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${level.emoji} ${level.displayName}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Casillero #$cellNumber',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (question.hint.isNotEmpty && _showHint) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('💡 ', style: TextStyle(fontSize: 16)),
                          Expanded(
                            child: Text(
                              question.hint,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  if (question.hint.isNotEmpty && !_showHint)
                    OutlinedButton.icon(
                      onPressed: () => setState(() => _showHint = true),
                      icon: const Icon(Icons.lightbulb_outline),
                      label: const Text('💡 Pista'),
                    ),
                  if (question.hint.isNotEmpty && !_showHint)
                    const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text(
                    '👨 Papá valida:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() => _showHint = false);
                            game.answerQuestion(true);
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('✅ Correcto'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() => _showHint = false);
                            game.answerQuestion(false);
                          },
                          icon: const Icon(Icons.close),
                          label: const Text('❌ Incorrecto'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}