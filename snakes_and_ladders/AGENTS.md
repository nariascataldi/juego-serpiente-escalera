# Snakes and Ladders — Flutter App

## Build Commands

```bash
cd snakes_and_ladders

# Android
flutter build apk --debug   # Testing (~100-140 MB)
flutter build apk --release # Production (~47 MB)

# Web
flutter build web --release

# Development
flutter analyze
flutter test
flutter doctor
```

## Critical Flutter Gotchas

### Extension methods are tree-shaken in release builds
**Symptom:** Release APK crashes; web build has stack overflow.

Extension methods on primitive types (`int.sqrt()`, `double.sqrt()`) get eliminated by Dart's tree-shaking. Always use `dart:math` directly:
```dart
import 'dart:math' as math;
math.sqrt(value); // NOT value.sqrt()
```

### Never call setState() during build()
**Symptom:** Stack overflow / infinite rebuild loop.

Calling any method that modifies state (including `_updatePlayerEmojis()`) inside `build()` causes infinite rebuild. Move state mutations to `initState()` or `didChangeDependencies()`.

### Use ValueNotifier for animation loops, not notifyListeners()
`GameProvider` uses `ValueNotifier` for animation state to avoid `notifyListeners()` on every frame during piece movement.

## Architecture

- `lib/data/poetry_questions.dart`, `natural_science_questions.dart`, `social_science_questions.dart` — question modules (add questions here)
- `lib/data/questions.dart` — barrel export
- `lib/data/board_config.dart` — snakes (8), ladders (8), cell types (44 question cells)
- `lib/models/question.dart` — `QuestionEntry`, `QuestionModel`, `QuestionCategory`
- `lib/providers/game_provider.dart` — `ChangeNotifier` + `ValueNotifier` for animation
- `lib/widgets/board_widget.dart` — 10x10 grid with `CustomPaint` for snakes/ladders

## Adding Questions

In the appropriate module file:
```dart
QuestionEntry(
  q: 'Tu pregunta aquí',
  hint: 'La pista para papá',
  category: 'Tu categoría',
),
```

No difficulty levels exist (removed in v2.0.0).

## Key Files

| File | Purpose |
|------|---------|
| `lib/widgets/board_widget.dart:73` | Snakes and ladders painter (CustomPaint) |
| `lib/providers/game_provider.dart` | Game state, turn logic, animation controller |
| `lib/screens/modals/question_modal.dart` | Question display + validation flow |
| `lib/data/board_config.dart` | Board layout, snakes/ladders map |