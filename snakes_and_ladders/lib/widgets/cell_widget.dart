import 'package:flutter/material.dart';
import '../data/board_config.dart';
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

  static Color get _backgroundColor0 => const Color(0xFFFAFAFA);
  static Color get _backgroundColor1 => const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    final cellType = BoardConfig.getCellType(cellNumber);
    final hasQuestion = BoardConfig.hasQuestion(cellNumber);
    final isGoal = cellNumber == 100;
    final isStart = cellNumber == 1;

    Color backgroundColor;
    if (isGoal) {
      backgroundColor = const Color(0xFFFBBF24).withValues(alpha: 0.3);
    } else if (isStart) {
      backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.2);
    } else {
      final row = (cellNumber - 1) ~/ BoardConfig.boardSize;
      backgroundColor = row % 2 == 0 ? _backgroundColor0 : _backgroundColor1;
    }

    final borderColor = isHighlighted
        ? AppTheme.primaryColor
        : Colors.grey.shade300;
    final borderWidth = isHighlighted ? 2.0 : 0.5;
    final fillColor = isHighlighted
        ? AppTheme.primaryColor.withValues(alpha: 0.3)
        : backgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(color: borderColor, width: borderWidth),
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
                    .map((emoji) => Text(emoji, style: TextStyle(fontSize: 14)))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
