class BoardConfig {
  static const int boardSize = 10;
  static const int totalCells = 100;

  static const Map<int, int> ladders = {
    4: 14,
    9: 31,
    21: 42,
    28: 84,
    36: 44,
    51: 67,
    71: 91,
    80: 100,
  };

  static const Map<int, int> snakes = {
    17: 7,
    54: 34,
    62: 19,
    64: 60,
    87: 24,
    93: 73,
    95: 75,
    99: 78,
  };

  static bool isLadder(int cellNumber) => ladders.containsKey(cellNumber);
  static bool isSnake(int cellNumber) => snakes.containsKey(cellNumber);

  static int? getLadderDestination(int cellNumber) => ladders[cellNumber];
  static int? getSnakeDestination(int cellNumber) => snakes[cellNumber];

  static int getDestination(int cellNumber) {
    if (isLadder(cellNumber)) {
      return ladders[cellNumber]!;
    } else if (isSnake(cellNumber)) {
      return snakes[cellNumber]!;
    }
    return cellNumber;
  }

  static CellType getCellType(int cellNumber) {
    if (isLadder(cellNumber)) return CellType.ladder;
    if (isSnake(cellNumber)) return CellType.snake;
    return CellType.normal;
  }

  static int getCellNumber(int row, int col) {
    final actualRow = boardSize - 1 - row;
    if (actualRow % 2 == 0) {
      return actualRow * boardSize + col + 1;
    } else {
      return actualRow * boardSize + (boardSize - 1 - col) + 1;
    }
  }

  static ({int row, int col}) getCellPosition(int cellNumber) {
    final actualRow = (cellNumber - 1) ~/ boardSize;
    final col = actualRow % 2 == 0
        ? (cellNumber - 1) % boardSize
        : boardSize - 1 - ((cellNumber - 1) % boardSize);
    final row = boardSize - 1 - actualRow;
    return (row: row, col: col);
  }
}

enum CellType { normal, ladder, snake, question }

extension CellTypeExtension on CellType {
  String get emoji {
    switch (this) {
      case CellType.ladder:
        return '🪜';
      case CellType.snake:
        return '🐍';
      case CellType.question:
        return '❓';
      case CellType.normal:
        return '';
    }
  }
}