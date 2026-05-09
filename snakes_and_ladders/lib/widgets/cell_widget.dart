import 'package:flutter/material.dart';
import '../data/board_config.dart';
import '../data/questions_db.dart';
import '../theme.dart';

class CellWidget extends StatelessWidget {
  final int cellNumber;
  final bool isHighlighted;
  final List<String> playerEmojis;

  const CellWidget({
    super.key,
    required this.cellNumber,
    this.isHighlighted = false,
    this.playerEmojis = const [],
  });

  @override
  Widget build(BuildContext context) {
    final cellType = BoardConfig.getCellType(cellNumber);
    final hasQuestion = QuestionsDatabase.hasQuestion(cellNumber);
    final isGoal = cellNumber == 100;
    final isStart = cellNumber == 1;

    Color backgroundColor;
    if (isGoal) {
      backgroundColor = const Color(0xFFFBBF24).withValues(alpha: 0.3);
    } else if (isStart) {
      backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.2);
    } else {
      final row = (cellNumber - 1) ~/ BoardConfig.boardSize;
      backgroundColor = row % 2 == 0
          ? Colors.grey.shade100
          : Colors.grey.shade200;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppTheme.primaryColor.withValues(alpha: 0.3)
            : backgroundColor,
        border: Border.all(
          color: isHighlighted
              ? AppTheme.primaryColor
              : Colors.grey.shade300,
          width: isHighlighted ? 2 : 0.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 2,
            left: 4,
            child: Text(
              '$cellNumber',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          if (cellType == CellType.ladder)
            const Positioned(
              top: 2,
              right: 2,
              child: Text('🪜', style: TextStyle(fontSize: 12)),
            ),
          if (cellType == CellType.snake)
            const Positioned(
              top: 2,
              right: 2,
              child: Text('🐍', style: TextStyle(fontSize: 12)),
            ),
          if (hasQuestion && cellType == CellType.normal)
            const Positioned(
              top: 2,
              right: 2,
              child: Text('❓', style: TextStyle(fontSize: 12)),
            ),
          if (isGoal)
            const Positioned(
              top: 2,
              right: 2,
              child: Text('🏆', style: TextStyle(fontSize: 12)),
            ),
          if (playerEmojis.isNotEmpty)
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: playerEmojis
                    .map((emoji) => Text(
                          emoji,
                          style: const TextStyle(fontSize: 14),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}