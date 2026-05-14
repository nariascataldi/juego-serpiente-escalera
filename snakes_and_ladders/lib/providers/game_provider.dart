import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../models/question.dart';
import '../models/game_config.dart';
import '../data/questions_db.dart';
import '../data/board_config.dart';

enum GameScreen { start, game }

enum GameState { idle, rolling, moving, answering, event, won }

class PendingEvent {
  final int from;
  final int to;
  final bool isLadder;

  PendingEvent({required this.from, required this.to, required this.isLadder});
}

class GameLog {
  final String message;
  final DateTime timestamp;

  GameLog(this.message) : timestamp = DateTime.now();
}

class GameProvider extends ChangeNotifier {
  List<Player> _players = [];
  int _currentPlayerIndex = 0;
  GameConfig _config = const GameConfig();
  GameScreen _currentScreen = GameScreen.start;
  GameState _gameState = GameState.idle;
  int _diceValue = 0;
  int _turnCount = 0;
  int? _highlightedCell;
  final ValueNotifier<int?> highlightedCellNotifier = ValueNotifier<int?>(null);
  QuestionModel? _currentQuestion;
  int? _currentQuestionCell;
  bool _isSpecialQuestion = false;
  PendingEvent? _pendingEvent;
  Player? _winner;
  List<GameLog> _logs = [];

  List<Player> get players => _players;
  int get currentPlayerIndex => _currentPlayerIndex;
  GameConfig get config => _config;
  GameScreen get currentScreen => _currentScreen;
  GameState get gameState => _gameState;
  int get diceValue => _diceValue;
  int get turnCount => _turnCount;
  int? get highlightedCell => _highlightedCell;
  QuestionModel? get currentQuestion => _currentQuestion;
  int? get currentQuestionCell => _currentQuestionCell;
  bool get isSpecialQuestion => _isSpecialQuestion;
  Player? get winner => _winner;
  List<GameLog> get logs => _logs;

  Player? get currentPlayer =>
      _players.isNotEmpty ? _players[_currentPlayerIndex] : null;

  void updateConfig(GameConfig newConfig) {
    _config = newConfig;
    notifyListeners();
  }

  void addPlayer(String name) {
    if (_players.length < 4) {
      final colors = ['player1', 'player2', 'player3', 'player4'];
      final emojis = ['🔵', '🔴', '🟢', '🟡'];
      _players.add(Player(
        id: _players.length + 1,
        name: name.isEmpty ? 'Jugador ${_players.length + 1}' : name,
        color: colors[_players.length],
        emoji: emojis[_players.length],
      ));
      notifyListeners();
    }
  }

  void removePlayer(int index) {
    if (index >= 0 && index < _players.length) {
      _players.removeAt(index);
      notifyListeners();
    }
  }

  void clearPlayers() {
    _players.clear();
    notifyListeners();
  }

  void startGame() {
    if (_players.isEmpty) {
      addPlayer('Jugador 1');
    }

    _currentScreen = GameScreen.game;
    _gameState = GameState.idle;
    _currentPlayerIndex = 0;
    _turnCount = 0;
    _logs.clear();
    _logs.add(GameLog('🎮 ¡El juego ha comenzado!'));

    for (var player in _players) {
      player.position = 0;
      player.correctAnswers = 0;
      player.wrongAnswers = 0;
      player.turnsPlayed = 0;
      player.skipNextTurn = false;
    }

    notifyListeners();
  }

  void restartGame() {
    _currentScreen = GameScreen.start;
    _gameState = GameState.idle;
    _currentPlayerIndex = 0;
    _diceValue = 0;
    _turnCount = 0;
    _highlightedCell = null;
    highlightedCellNotifier.value = null;
    _currentQuestion = null;
    _currentQuestionCell = null;
    _isSpecialQuestion = false;
    _pendingEvent = null;
    _winner = null;
    _logs.clear();

    for (var player in _players) {
      player.position = 0;
      player.correctAnswers = 0;
      player.wrongAnswers = 0;
      player.turnsPlayed = 0;
      player.skipNextTurn = false;
    }

    notifyListeners();
  }

  Future<void> rollDice() async {
    if (_gameState != GameState.idle) return;

    final player = currentPlayer;
    if (player == null) return;

    if (player.skipNextTurn) {
      player.skipNextTurn = false;
      addLog('⏭️ ${player.name} pierde turno.');
      _nextTurn();
      return;
    }

    _gameState = GameState.rolling;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    final random = Random();
    _diceValue = random.nextInt(6) + 1;

    addLog('🎲 ${player.name} sacó $_diceValue');
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    await _movePlayer(player);
  }

  Future<void> _movePlayer(Player player) async {
    _gameState = GameState.moving;
    notifyListeners();

    final oldPos = player.position;
    var newPos = oldPos == 0 ? _diceValue : oldPos + _diceValue;

    if (newPos > 100) {
      addLog('📍 ${player.name} necesita exacto para llegar a 100. Se queda en $oldPos.');
      _gameState = GameState.idle;
      _nextTurn();
      notifyListeners();
      return;
    }

    await _animateMovement(player, oldPos, newPos);

    player.position = newPos;
    player.turnsPlayed++;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    if (newPos == 100) {
      _handleWin(player);
      return;
    }

    _handleCellEvent(player, newPos);
  }

  Future<void> _animateMovement(Player player, int fromPos, int toPos) async {
    final start = max(1, fromPos);
    final direction = toPos > start ? 1 : -1;

    for (var pos = start; pos != toPos; pos += direction) {
      player.position = pos;
      _highlightedCell = pos;
      highlightedCellNotifier.value = pos;
      await Future.delayed(const Duration(milliseconds: 150));
    }

    player.position = toPos;
    _highlightedCell = toPos;
    highlightedCellNotifier.value = toPos;

    await Future.delayed(const Duration(milliseconds: 300));
    _highlightedCell = null;
    highlightedCellNotifier.value = null;
  }

  void _handleCellEvent(Player player, int cellNum) {
    final cellType = BoardConfig.getCellType(cellNum);
    final hasQuestion = BoardConfig.hasQuestion(cellNum);

    if (cellType == CellType.ladder) {
      _pendingEvent = PendingEvent(
        from: cellNum,
        to: BoardConfig.getLadderDestination(cellNum)!,
        isLadder: true,
      );
      _showQuestion(player, cellNum, true);
    } else if (cellType == CellType.snake) {
      _pendingEvent = PendingEvent(
        from: cellNum,
        to: BoardConfig.getSnakeDestination(cellNum)!,
        isLadder: false,
      );
      _showQuestion(player, cellNum, true);
    } else if (hasQuestion) {
      _showQuestion(player, cellNum, false);
    } else {
      _gameState = GameState.idle;
      _nextTurn();
      notifyListeners();
    }
  }

  void _showQuestion(Player player, int cellNum, bool isSpecial) {
    _isSpecialQuestion = isSpecial;
    _currentQuestionCell = cellNum;
    _currentQuestion = QuestionsDatabase.getQuestionForCell(
      cellNum,
      _config.topic,
    );
    _gameState = GameState.answering;
    notifyListeners();
  }

  void answerQuestion(bool correct) {
    final player = currentPlayer;
    if (player == null || _currentQuestion == null) return;

    if (correct) {
      player.correctAnswers++;
      addLog('✅ ${player.name} respondió correctamente.');

      if (_pendingEvent != null && _pendingEvent!.isLadder) {
        _showEventAndMove(_pendingEvent!);
        _pendingEvent = null;
      } else if (_pendingEvent != null && !_pendingEvent!.isLadder) {
        addLog('🛡️ ${player.name} evitó la serpiente respondiendo bien.');
        _pendingEvent = null;
        _gameState = GameState.idle;
        _nextTurn();
      } else {
        _gameState = GameState.idle;
        _nextTurn();
      }
    } else {
      player.wrongAnswers++;
      addLog('❌ ${player.name} respondió incorrectamente.');

      if (_pendingEvent != null && !_pendingEvent!.isLadder) {
        _showEventAndMove(_pendingEvent!);
        _pendingEvent = null;
      } else if (_pendingEvent != null && _pendingEvent!.isLadder) {
        addLog('🚫 ${player.name} no puede subir la escalera.');
        _pendingEvent = null;
        _applyWrongRule(player);
      } else {
        _applyWrongRule(player);
      }
    }

    _currentQuestion = null;
    _currentQuestionCell = null;
    _isSpecialQuestion = false;
    notifyListeners();
  }

  void _showEventAndMove(PendingEvent event) async {
    _gameState = GameState.event;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1500));

    final player = currentPlayer;
    if (player == null) return;

    await _animateMovement(player, player.position, event.to);
    player.position = event.to;
    notifyListeners();

    if (player.position == 100) {
      _handleWin(player);
      return;
    }

    _gameState = GameState.idle;
    _nextTurn();
    notifyListeners();
  }

  void _applyWrongRule(Player player) {
    switch (_config.wrongRule) {
      case WrongRule.stay:
        addLog('🛑 ${player.name} se queda en casillero ${player.position}.');
        break;
      case WrongRule.back:
        final goBack = min(player.position - 1, _diceValue);
        if (goBack > 0) {
          player.position = max(1, player.position - goBack);
          addLog('🔙 ${player.name} retrocede a casillero ${player.position}.');
        }
        break;
      case WrongRule.skip:
        player.skipNextTurn = true;
        addLog('⏭️ ${player.name} pierde el próximo turno.');
        break;
    }

    _gameState = GameState.idle;
    _nextTurn();
    notifyListeners();
  }

  void _nextTurn() {
    _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
    if (_currentPlayerIndex == 0) _turnCount++;
    notifyListeners();
  }

  void _handleWin(Player player) {
    _gameState = GameState.won;
    _winner = player;
    addLog('🏆 ${player.name} ha ganado el juego!');
    notifyListeners();
  }

  void addLog(String message) {
    _logs.insert(0, GameLog(message));
    if (_logs.length > 30) {
      _logs.removeLast();
    }
  }

  void closeEventModal() {
    if (_gameState == GameState.event && _pendingEvent != null) {
      _showEventAndMove(_pendingEvent!);
    }
  }
}