import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:snakes_and_ladders/main.dart';
import 'package:snakes_and_ladders/providers/game_provider.dart';
import 'package:snakes_and_ladders/screens/start_screen.dart';
import 'package:snakes_and_ladders/data/board_config.dart';
import 'package:snakes_and_ladders/data/questions_db.dart';

void main() {
  testWidgets('App smoke test - renders StartScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const SnakesAndLaddersApp());
    await tester.pumpAndSettle();

    expect(find.text('Serpientes'), findsOneWidget);
    expect(find.text('& Escaleras'), findsOneWidget);
  });

  test('BoardConfig has correct cellTypes', () {
    expect(BoardConfig.getCellType(1), CellType.normal);
    expect(BoardConfig.getCellType(4), CellType.ladder);
    expect(BoardConfig.getCellType(17), CellType.snake);
    expect(BoardConfig.getCellType(2), CellType.question);
  });

  test('BoardConfig question cells', () {
    expect(BoardConfig.hasQuestion(2), isTrue);
    expect(BoardConfig.hasQuestion(1), isFalse);
    expect(BoardConfig.hasQuestion(98), isTrue);
  });

  test('QuestionsDatabase returns questions', () {
    final q = QuestionsDatabase.getQuestionForCell(2, QuestionTopic.poetry);
    expect(q.question, isNotEmpty);
    expect(q.hint, isNotEmpty);
  });

  test('QuestionsDatabase counts', () {
    expect(QuestionsDatabase.poetryCount, greaterThan(0));
    expect(QuestionsDatabase.naturalScienceCount, greaterThan(0));
    expect(QuestionsDatabase.socialScienceCount, greaterThan(0));
  });

  test('GameProvider initial state', () {
    final provider = GameProvider();
    expect(provider.currentScreen, GameScreen.start);
    expect(provider.gameState, GameState.idle);
    expect(provider.players, isEmpty);
  });
}