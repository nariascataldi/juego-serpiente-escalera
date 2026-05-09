class Question {
  final String question;
  final String hint;
  final String category;
  final String level;

  const Question({
    required this.question,
    required this.hint,
    required this.category,
    required this.level,
  });

  factory Question.fromMap(Map<String, dynamic> map, String level) {
    return Question(
      question: map['q'] ?? '',
      hint: map['hint'] ?? '',
      category: map['category'] ?? '',
      level: level,
    );
  }
}

enum QuestionLevel { easy, medium, hard }

enum QuestionTopic { poetry, naturalSciences, socialSciences }

extension QuestionLevelExtension on QuestionLevel {
  String get displayName {
    switch (this) {
      case QuestionLevel.easy:
        return 'Básico';
      case QuestionLevel.medium:
        return 'Medio';
      case QuestionLevel.hard:
        return 'Avanzado';
    }
  }

  String get emoji {
    switch (this) {
      case QuestionLevel.easy:
        return '🟢';
      case QuestionLevel.medium:
        return '🟡';
      case QuestionLevel.hard:
        return '🔴';
    }
  }
}

extension QuestionTopicExtension on QuestionTopic {
  String get displayName {
    switch (this) {
      case QuestionTopic.poetry:
        return 'Poesía';
      case QuestionTopic.naturalSciences:
        return 'Cs. Naturales';
      case QuestionTopic.socialSciences:
        return 'Cs. Sociales';
    }
  }

  String get emoji {
    switch (this) {
      case QuestionTopic.poetry:
        return '📖';
      case QuestionTopic.naturalSciences:
        return '🌿';
      case QuestionTopic.socialSciences:
        return '🏛️';
    }
  }
}