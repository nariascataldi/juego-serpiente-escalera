import 'questions_db.dart';

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

  static const Set<int> _questionCells = {
    2,
    3,
    5,
    7,
    8,
    10,
    12,
    15,
    16,
    18,
    20,
    22,
    23,
    25,
    27,
    30,
    33,
    35,
    37,
    40,
    42,
    45,
    48,
    50,
    52,
    55,
    57,
    60,
    62,
    65,
    68,
    70,
    72,
    75,
    77,
    80,
    82,
    85,
    88,
    90,
    92,
    95,
    97,
    98,
  };

  static const Map<int, CellType> _cellTypes = {
    1: CellType.normal,
    2: CellType.question,
    3: CellType.question,
    4: CellType.ladder,
    5: CellType.question,
    6: CellType.normal,
    7: CellType.question,
    8: CellType.question,
    9: CellType.ladder,
    10: CellType.question,
    11: CellType.question,
    12: CellType.question,
    13: CellType.question,
    14: CellType.normal,
    15: CellType.question,
    16: CellType.question,
    17: CellType.snake,
    18: CellType.question,
    19: CellType.normal,
    20: CellType.question,
    21: CellType.ladder,
    22: CellType.question,
    23: CellType.question,
    24: CellType.normal,
    25: CellType.question,
    26: CellType.normal,
    27: CellType.question,
    28: CellType.ladder,
    29: CellType.normal,
    30: CellType.question,
    31: CellType.normal,
    32: CellType.normal,
    33: CellType.question,
    34: CellType.normal,
    35: CellType.question,
    36: CellType.ladder,
    37: CellType.question,
    38: CellType.normal,
    39: CellType.normal,
    40: CellType.question,
    41: CellType.normal,
    42: CellType.question,
    43: CellType.normal,
    44: CellType.normal,
    45: CellType.question,
    46: CellType.normal,
    47: CellType.normal,
    48: CellType.question,
    49: CellType.normal,
    50: CellType.question,
    51: CellType.ladder,
    52: CellType.question,
    53: CellType.normal,
    54: CellType.snake,
    55: CellType.question,
    56: CellType.normal,
    57: CellType.question,
    58: CellType.normal,
    59: CellType.normal,
    60: CellType.question,
    61: CellType.normal,
    62: CellType.snake,
    63: CellType.normal,
    64: CellType.snake,
    65: CellType.question,
    66: CellType.normal,
    67: CellType.normal,
    68: CellType.question,
    69: CellType.normal,
    70: CellType.question,
    71: CellType.ladder,
    72: CellType.question,
    73: CellType.normal,
    74: CellType.normal,
    75: CellType.question,
    76: CellType.normal,
    77: CellType.question,
    78: CellType.normal,
    79: CellType.normal,
    80: CellType.ladder,
    81: CellType.normal,
    82: CellType.question,
    83: CellType.normal,
    84: CellType.normal,
    85: CellType.question,
    86: CellType.normal,
    87: CellType.snake,
    88: CellType.question,
    89: CellType.normal,
    90: CellType.question,
    91: CellType.normal,
    92: CellType.question,
    93: CellType.snake,
    94: CellType.normal,
    95: CellType.question,
    96: CellType.normal,
    97: CellType.question,
    98: CellType.question,
    99: CellType.snake,
    100: CellType.normal,
  };

  static bool isLadder(int cellNumber) => ladders.containsKey(cellNumber);
  static bool isSnake(int cellNumber) => snakes.containsKey(cellNumber);
  static bool hasQuestion(int cellNumber) =>
      _questionCells.contains(cellNumber);

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

  static CellType getCellType(int cellNumber) =>
      _cellTypes[cellNumber] ?? CellType.normal;

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
