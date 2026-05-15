import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../data/board_config.dart';
import 'cell_widget.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  Map<int, List<String>> _playerEmojisByCell = {};
  int? _lastHighlightedCell;

  void _updatePlayerEmojis(GameProvider game) {
    final needsUpdate = _lastHighlightedCell != game.highlightedCell;

    if (needsUpdate || _playerEmojisByCell.isEmpty) {
      final newMap = <int, List<String>>{};
      for (final player in game.players) {
        newMap.putIfAbsent(player.position, () => []).add(player.emoji);
      }
      _playerEmojisByCell = newMap;
      _lastHighlightedCell = game.highlightedCell;
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    _updatePlayerEmojis(game);

    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: SnakesAndLaddersPainter(),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: BoardConfig.boardSize,
                ),
                itemCount: BoardConfig.totalCells,
                itemBuilder: (context, index) {
                  final row = index ~/ BoardConfig.boardSize;
                  final col = index % BoardConfig.boardSize;
                  final cellNumber = BoardConfig.getCellNumber(row, col);

                  return CellWidget(
                    key: ValueKey(cellNumber),
                    cellNumber: cellNumber,
                    isHighlighted: game.highlightedCell == cellNumber,
                    playerEmojis: _playerEmojisByCell[cellNumber] ?? const [],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class SnakesAndLaddersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / BoardConfig.boardSize;
    final paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (final entry in BoardConfig.ladders.entries) {
      final fromPos = BoardConfig.getCellPosition(entry.key);
      final toPos = BoardConfig.getCellPosition(entry.value);

      final x1 = fromPos.col * cellSize + cellSize / 2;
      final y1 = fromPos.row * cellSize + cellSize / 2;
      final x2 = toPos.col * cellSize + cellSize / 2;
      final y2 = toPos.row * cellSize + cellSize / 2;

      paint.color = const Color(0xFF10B981).withValues(alpha: 0.6);

      final offset = cellSize * 0.08;
      final angle = (y2 - y1).abs() > 0.001
          ? (y2 - y1).abs() / (x2 - x1).abs()
          : 0.0;
      final perpX = angle * offset;
      final perpY = offset;

      canvas.drawLine(
        Offset(x1 - perpX, y1 - perpY),
        Offset(x2 - perpX, y2 - perpY),
        paint,
      );
      canvas.drawLine(
        Offset(x1 + perpX, y1 + perpY),
        Offset(x2 + perpX, y2 + perpY),
        paint,
      );

      final dist = ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
      final numRungs = math.sqrt(dist / (cellSize * 0.5)).toInt().clamp(3, 8);
      for (var i = 1; i < numRungs; i++) {
        final t = i / numRungs;
        final rx = x1 + (x2 - x1) * t;
        final ry = y1 + (y2 - y1) * t;
        canvas.drawLine(
          Offset(rx - perpX, ry - perpY),
          Offset(rx + perpX, ry + perpY),
          paint,
        );
      }
    }

    for (final entry in BoardConfig.snakes.entries) {
      final fromPos = BoardConfig.getCellPosition(entry.key);
      final toPos = BoardConfig.getCellPosition(entry.value);

      final x1 = fromPos.col * cellSize + cellSize / 2;
      final y1 = fromPos.row * cellSize + cellSize / 2;
      final x2 = toPos.col * cellSize + cellSize / 2;
      final y2 = toPos.row * cellSize + cellSize / 2;

      final midX = (x1 + x2) / 2 + (x2 - x1) * 0.3;
      final midY = (y1 + y2) / 2;

      paint.color = const Color(0xFFEF4444).withValues(alpha: 0.6);
      final path = Path()
        ..moveTo(x1, y1)
        ..quadraticBezierTo(midX, midY, x2, y2);
      canvas.drawPath(path, paint);

      final headPaint = Paint()
        ..color = const Color(0xFFEF4444).withValues(alpha: 0.8)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x1, y1), cellSize * 0.08, headPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
