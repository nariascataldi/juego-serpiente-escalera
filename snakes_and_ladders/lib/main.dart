import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/start_screen.dart';
import 'screens/game_screen.dart';
import 'theme.dart';

void main() {
  runApp(const SnakesAndLaddersApp());
}

class SnakesAndLaddersApp extends StatelessWidget {
  const SnakesAndLaddersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MaterialApp(
        title: 'Serpientes y Escaleras',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        switch (game.currentScreen) {
          case GameScreen.start:
            return const StartScreen();
          case GameScreen.game:
            return const GameScreenWidget();
        }
      },
    );
  }
}