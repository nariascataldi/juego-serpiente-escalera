import 'dart:math';
import '../models/question.dart';
import 'poetry_questions.dart';
import 'natural_science_questions.dart';
import 'social_science_questions.dart';

class QuestionsDatabase {
  static List<QuestionEntry>? _poetryCache;
  static List<QuestionEntry>? _naturalScienceCache;
  static List<QuestionEntry>? _socialScienceCache;

  static int get poetryCount => poetryQuestions.length;
  static int get naturalScienceCount => naturalScienceQuestions.length;
  static int get socialScienceCount => socialScienceQuestions.length;
  static int get totalCount => poetryCount + naturalScienceCount + socialScienceCount;

  static List<QuestionEntry> _getCache(QuestionTopic topic) {
    switch (topic) {
      case QuestionTopic.poetry:
        _poetryCache ??= [...poetryQuestions];
        return _poetryCache!;
      case QuestionTopic.naturalSciences:
        _naturalScienceCache ??= [...naturalScienceQuestions];
        return _naturalScienceCache!;
      case QuestionTopic.socialSciences:
        _socialScienceCache ??= [...socialScienceQuestions];
        return _socialScienceCache!;
    }
  }

  static const List<int> _fixedQuestionCells = [
    2, 5, 8, 12, 15, 18, 20, 22, 25, 30,
    35, 40, 45, 50, 55, 60, 65, 70, 75, 80,
    85, 90, 95, 98,
  ];

  static const List<int> _reinforcementCells = [
    3, 7, 10, 16, 23, 27, 33, 37, 42, 48,
    52, 57, 62, 68, 72, 77, 82, 88, 92, 97,
  ];

  static bool hasQuestion(int cellNumber) {
    return _fixedQuestionCells.contains(cellNumber) ||
        _reinforcementCells.contains(cellNumber);
  }

  static QuestionModel getQuestionForCell(int cellNumber, QuestionTopic topic) {
    final pool = _getCache(topic);
    if (pool.isEmpty) {
      return const QuestionModel(
        question: 'Sin preguntas disponibles',
        hint: '',
        category: 'General',
      );
    }

    if (_fixedQuestionCells.contains(cellNumber)) {
      final index = _fixedQuestionCells.indexOf(cellNumber);
      return pool[index % pool.length].toModel();
    }

    if (_reinforcementCells.contains(cellNumber)) {
      final index = _reinforcementCells.indexOf(cellNumber);
      return pool[index % pool.length].toModel();
    }

    return getRandomQuestion(topic);
  }

  static QuestionModel getRandomQuestion(QuestionTopic topic) {
    final pool = _getCache(topic);
    if (pool.isEmpty) {
      return const QuestionModel(
        question: 'Sin preguntas disponibles',
        hint: '',
        category: 'General',
      );
    }
    return pool[Random().nextInt(pool.length)].toModel();
  }
}