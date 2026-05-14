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
  final WrongRule wrongRule;

  const GameConfig({
    this.topic = QuestionTopic.naturalSciences,
    this.wrongRule = WrongRule.stay,
  });

  GameConfig copyWith({
    QuestionTopic? topic,
    WrongRule? wrongRule,
  }) {
    return GameConfig(
      topic: topic ?? this.topic,
      wrongRule: wrongRule ?? this.wrongRule,
    );
  }
}