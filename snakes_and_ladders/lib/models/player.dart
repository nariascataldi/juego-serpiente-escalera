class Player {
  final int id;
  final String name;
  final String color;
  final String emoji;
  int position;
  int correctAnswers;
  int wrongAnswers;
  int turnsPlayed;
  bool skipNextTurn;

  Player({
    required this.id,
    required this.name,
    required this.color,
    required this.emoji,
    this.position = 0,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.turnsPlayed = 0,
    this.skipNextTurn = false,
  });

  Player copyWith({
    int? id,
    String? name,
    String? color,
    String? emoji,
    int? position,
    int? correctAnswers,
    int? wrongAnswers,
    int? turnsPlayed,
    bool? skipNextTurn,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      emoji: emoji ?? this.emoji,
      position: position ?? this.position,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      turnsPlayed: turnsPlayed ?? this.turnsPlayed,
      skipNextTurn: skipNextTurn ?? this.skipNextTurn,
    );
  }

  double get accuracy {
    final total = correctAnswers + wrongAnswers;
    return total > 0 ? (correctAnswers / total) * 100 : 0;
  }
}