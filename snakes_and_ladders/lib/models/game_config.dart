import 'question.dart';

enum WrongRule { stay, back, skip }

extension WrongRuleExtension on WrongRule {
  String get displayName {
    switch (this) {
      case WrongRule.stay:
        return 'Se queda';
      case WrongRule.back:
        return 'Retrocede';
      case WrongRule.skip:
        return 'Pierde turno';
    }
  }

  String get emoji {
    switch (this) {
      case WrongRule.stay:
        return '🛑';
      case WrongRule.back:
        return '🔙';
      case WrongRule.skip:
        return '⏭️';
    }
  }
}

class GameConfig {
  final QuestionTopic topic;
  final QuestionLevel difficulty;
  final WrongRule wrongRule;

  const GameConfig({
    this.topic = QuestionTopic.naturalSciences,
    this.difficulty = QuestionLevel.medium,
    this.wrongRule = WrongRule.stay,
  });

  GameConfig copyWith({
    QuestionTopic? topic,
    QuestionLevel? difficulty,
    WrongRule? wrongRule,
  }) {
    return GameConfig(
      topic: topic ?? this.topic,
      difficulty: difficulty ?? this.difficulty,
      wrongRule: wrongRule ?? this.wrongRule,
    );
  }
}