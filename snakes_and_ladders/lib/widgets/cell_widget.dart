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

  Color get _cellBackgroundColor {
    if (cellNumber == 100) {
      return const Color(0xFFFBBF24).withValues(alpha: 0.4);
    }
    if (cellNumber == 1) {
      return const Color(0xFF10B981).withValues(alpha: 0.25);
    }

    final cellType = BoardConfig.getCellType(cellNumber);
    final hasQuestion = BoardConfig.hasQuestion(cellNumber);

    if (cellType == CellType.question || hasQuestion) {
      return const Color(0xFFE0F2FE);
    }
    if (cellType == CellType.ladder) {
      return const Color(0xFFD1FAE5);
    }
    if (cellType == CellType.snake) {
      return const Color(0xFFFEE2E2);
    }

    final row = (cellNumber - 1) ~/ BoardConfig.boardSize;
    return row % 2 == 0 ? _backgroundColor0 : _backgroundColor1;
  }

  BoxDecoration get _cellDecoration {
    final isGoal = cellNumber == 100;
    final cellType = BoardConfig.getCellType(cellNumber);
    final hasQuestion = BoardConfig.hasQuestion(cellNumber);
    final isSpecialCell =
        cellType != CellType.normal &&
        !hasQuestion &&
        cellNumber != 1 &&
        cellNumber != 100;

    Color backgroundColor;
    List<BoxShadow>? boxShadow;

    if (isHighlighted) {
      backgroundColor = AppTheme.primaryColor.withValues(alpha: 0.35);
      boxShadow = [
        BoxShadow(
          color: AppTheme.primaryColor.withValues(alpha: 0.4),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ];
    } else {
      backgroundColor = _cellBackgroundColor;
      if (isGoal) {
        boxShadow = [
          BoxShadow(
            color: const Color(0xFFFBBF24).withValues(alpha: 0.3),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ];
      } else if (isSpecialCell) {
        boxShadow = [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 3,
            spreadRadius: 0.5,
          ),
        ];
      }
    }

    return BoxDecoration(
      gradient: isGoal
          ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
            )
          : null,
      color: isGoal ? null : backgroundColor,
      border: Border.all(
        color: isHighlighted
            ? AppTheme.primaryColor
            : (isGoal
                  ? const Color(0xFFD97706)
                  : (isSpecialCell
                        ? Colors.grey.shade400
                        : Colors.grey.shade300)),
        width: isHighlighted ? 2.0 : (isGoal ? 1.5 : 0.8),
      ),
      borderRadius: BorderRadius.circular(6),
      boxShadow: boxShadow,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cellType = BoardConfig.getCellType(cellNumber);
    final isGoal = cellNumber == 100;

    return Container(
      decoration: _cellDecoration,
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
          if (cellType == CellType.question)
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
