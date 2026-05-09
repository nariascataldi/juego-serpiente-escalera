import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';
import '../../theme.dart';

class WinModal extends StatefulWidget {
  const WinModal({super.key});

  @override
  State<WinModal> createState() => _WinModalState();
}

class _WinModalState extends State<WinModal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Confetti> _confetti;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _generateConfetti();
  }

  void _generateConfetti() {
    final random = Random();
    final colors = [
      const Color(0xFFFFD700),
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
      const Color(0xFFA78BFA),
      const Color(0xFFF97316),
      const Color(0xFF10B981),
    ];
    _confetti = List.generate(
      60,
      (i) => _Confetti(
        left: random.nextDouble() * 100,
        color: colors[random.nextInt(colors.length)],
        delay: random.nextDouble() * 2,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        if (game.gameState != GameState.won || game.winner == null) {
          return const SizedBox.shrink();
        }

        final winner = game.winner!;

        return Container(
          color: Colors.black54,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: _ConfettiPainter(
                      confetti: _confetti,
                      progress: _controller.value,
                    ),
                  );
                },
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  decoration: AppTheme.glassCard,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '🏆',
                        style: TextStyle(fontSize: 60),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '¡Felicidades!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFD700),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${winner.emoji} ${winner.name}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        '¡Ha llegado a la meta!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildStat('Turnos jugados', '${winner.turnsPlayed}'),
                      _buildStat(
                          'Respuestas correctas', '${winner.correctAnswers} ✅'),
                      _buildStat(
                          'Respuestas incorrectas', '${winner.wrongAnswers} ❌'),
                      _buildStat('Precisión', '${winner.accuracy.toStringAsFixed(0)}%'),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => game.restartGame(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('🔄 Jugar de nuevo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _Confetti {
  final double left;
  final Color color;
  final double delay;

  _Confetti({
    required this.left,
    required this.color,
    required this.delay,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_Confetti> confetti;
  final double progress;

  _ConfettiPainter({
    required this.confetti,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var c in confetti) {
      final adjustedProgress = (progress + c.delay) % 1.0;
      final top = adjustedProgress * size.height;
      final left = c.left / 100 * size.width;
      final opacity = adjustedProgress < 0.7 ? 1.0 : 1.0 - (adjustedProgress - 0.7) / 0.3;

      final paint = Paint()
        ..color = c.color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(left, top), 6, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}