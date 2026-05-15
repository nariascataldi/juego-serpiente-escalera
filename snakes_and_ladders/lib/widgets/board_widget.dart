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

  Offset _calculatePlayerOffset(
    int cellNumber,
    double cellSize,
    int playerIndex,
    int totalPlayers,
  ) {
    final pos = BoardConfig.getCellPosition(cellNumber);
    final colOffset =
        (playerIndex - (totalPlayers - 1) / 2) * (cellSize * 0.15);
    return Offset(
      pos.col * cellSize + cellSize / 2 + colOffset,
      pos.row * cellSize + cellSize / 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    _updatePlayerEmojis(game);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3A5F), Color(0xFF2D5A87), Color(0xFF1E3A5F)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3D7EB5), width: 3),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D2137).withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF3D7EB5).withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cellSize = constraints.maxWidth / BoardConfig.boardSize;

              return Stack(
                children: [
                  CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: SnakesAndLaddersPainter(),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                        playerEmojis:
                            _playerEmojisByCell[cellNumber] ?? const [],
                      );
                    },
                  ),
                  ...game.players.asMap().entries.map((entry) {
                    final index = entry.key;
                    final player = entry.value;
                    final position = _calculatePlayerOffset(
                      player.position,
                      cellSize,
                      index,
                      game.players.length,
                    );

                    return AnimatedPositioned(
                      key: ValueKey('player_${player.id}'),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      left: position.dx - cellSize * 0.35,
                      top: position.dy - cellSize * 0.35,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.8, end: 1.0),
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return Transform.scale(scale: value, child: child);
                        },
                        child: Container(
                          width: cellSize * 0.7,
                          height: cellSize * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                              BoxShadow(
                                color: Colors.amber.withValues(alpha: 0.4),
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFFD97706),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              player.emoji,
                              style: TextStyle(fontSize: cellSize * 0.32),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SnakesAndLaddersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / BoardConfig.boardSize;

    for (final entry in BoardConfig.ladders.entries) {
      final fromPos = BoardConfig.getCellPosition(entry.key);
      final toPos = BoardConfig.getCellPosition(entry.value);

      final x1 = fromPos.col * cellSize + cellSize / 2;
      final y1 = fromPos.row * cellSize + cellSize / 2;
      final x2 = toPos.col * cellSize + cellSize / 2;
      final y2 = toPos.row * cellSize + cellSize / 2;

      final ladderPaint = Paint()
        ..color = const Color(0xFF059669)
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final shadowPaint = Paint()
        ..color = const Color(0xFF059669).withValues(alpha: 0.3)
        ..strokeWidth = 8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final offset = cellSize * 0.1;
      final angle = (y2 - y1).abs() > 0.001
          ? (y2 - y1).abs() / (x2 - x1).abs()
          : 0.0;
      final perpX = angle * offset;
      final perpY = offset;

      canvas.drawLine(
        Offset(x1 - perpX, y1 - perpY),
        Offset(x2 - perpX, y2 - perpY),
        shadowPaint,
      );
      canvas.drawLine(
        Offset(x1 + perpX, y1 + perpY),
        Offset(x2 + perpX, y2 + perpY),
        shadowPaint,
      );

      canvas.drawLine(
        Offset(x1 - perpX, y1 - perpY),
        Offset(x2 - perpX, y2 - perpY),
        ladderPaint,
      );
      canvas.drawLine(
        Offset(x1 + perpX, y1 + perpY),
        Offset(x2 + perpX, y2 + perpY),
        ladderPaint,
      );

      final dist = ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
      final numRungs = math.sqrt(dist / (cellSize * 0.5)).toInt().clamp(4, 10);

      final rungPaint = Paint()
        ..color = const Color(0xFF10B981)
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      for (var i = 1; i < numRungs; i++) {
        final t = i / numRungs;
        final rx = x1 + (x2 - x1) * t;
        final ry = y1 + (y2 - y1) * t;
        canvas.drawLine(
          Offset(rx - perpX, ry - perpY),
          Offset(rx + perpX, ry + perpY),
          rungPaint,
        );
      }

      final topPaint = Paint()
        ..color = const Color(0xFF34D399)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(x1 + perpX, y1 + perpY),
        cellSize * 0.06,
        topPaint,
      );
      canvas.drawCircle(
        Offset(x2 + perpX, y2 + perpY),
        cellSize * 0.06,
        topPaint,
      );
    }

    for (final entry in BoardConfig.snakes.entries) {
      final fromPos = BoardConfig.getCellPosition(entry.key);
      final toPos = BoardConfig.getCellPosition(entry.value);

      final x1 = fromPos.col * cellSize + cellSize / 2;
      final y1 = fromPos.row * cellSize + cellSize / 2;
      final x2 = toPos.col * cellSize + cellSize / 2;
      final y2 = toPos.row * cellSize + cellSize / 2;

      final midX = (x1 + x2) / 2 + (x2 - x1) * 0.25;
      final midY = (y1 + y2) / 2;

      final shadowPath = Path()
        ..moveTo(x1, y1)
        ..quadraticBezierTo(midX, midY + 4, x2, y2);

      final shadowPaint = Paint()
        ..color = const Color(0xFFDC2626).withValues(alpha: 0.3)
        ..strokeWidth = 10
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(shadowPath, shadowPaint);

      final snakePaint = Paint()
        ..color = const Color(0xFFEF4444)
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final path = Path()
        ..moveTo(x1, y1)
        ..quadraticBezierTo(midX, midY, x2, y2);
      canvas.drawPath(path, snakePaint);

      final highlightPaint = Paint()
        ..color = const Color(0xFFFCA5A5)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, highlightPaint);

      final headPaint = Paint()
        ..color = const Color(0xFFB91C1C)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x1, y1), cellSize * 0.12, headPaint);

      final headHighlightPaint = Paint()
        ..color = const Color(0xFFEF4444)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x1, y1), cellSize * 0.08, headHighlightPaint);

      final eyePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(x1 - cellSize * 0.03, y1 - cellSize * 0.02),
        cellSize * 0.025,
        eyePaint,
      );
      canvas.drawCircle(
        Offset(x1 + cellSize * 0.03, y1 - cellSize * 0.02),
        cellSize * 0.025,
        eyePaint,
      );

      final pupilPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(x1 - cellSize * 0.03, y1 - cellSize * 0.02),
        cellSize * 0.012,
        pupilPaint,
      );
      canvas.drawCircle(
        Offset(x1 + cellSize * 0.03, y1 - cellSize * 0.02),
        cellSize * 0.012,
        pupilPaint,
      );

      final tailPaint = Paint()
        ..color = const Color(0xFFEF4444)
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        Offset(x2, y2),
        Offset(x2 + cellSize * 0.08, y2),
        tailPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
