# Snakes and Ladders — Workspace Root

## Project Location
`snakes_and_ladders/` — Flutter app (5th grade educational game)

## Key Gotchas

- Extension methods on primitives (`int.sqrt()`, `double.sqrt()`) are tree-shaken in release builds → use `dart:math` directly
- Never call `setState()` from inside `build()` — causes stack overflow
- Use `ValueNotifier` for animation state, not `notifyListeners()`

See `snakes_and_ladders/AGENTS.md` for full details.