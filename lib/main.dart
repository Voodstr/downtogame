import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'downtogame.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final game = DownToGame();
  runApp(MyApp(game: game));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.game});

  final DownToGame game;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(game: game),
    );
  }
}