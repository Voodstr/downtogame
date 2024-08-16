import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'Components/pixelizedstadiumborder.dart';
import 'DB/database.dart';
import 'downtogame.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();

 /* await database.into(database.todoItems).insert(TodoItemsCompanion.insert(
    title: 'todo: finish drift setup',
    content: 'We can now write queries and define our own tables.',
  ));
  
  */
  List<TodoItem> allItems = await database.select(database.todoItems).get();

  if (kDebugMode) {
    print('items in database: $allItems');
  }
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
          fontFamily: GoogleFonts.pressStart2p().fontFamily),
      home: GameWidget(
        game: game,
        overlayBuilderMap: {
          "PauseMenu": (BuildContext context, DownToGame game) {
            return Container(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        game.overlays.remove("PauseMenu"),
                        game.resumeEngine()
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStatePropertyAll<PixelizedStadiumBorder>(
                                  PixelizedStadiumBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Colors.cyan, width: 3.0),
                                      pixelRadius: 20.0,
                                      pixelSize: 5.0))),
                      child: const Text("Resume"),
                    )
                  ],
                ));
          }
        },
      ),
    );
  }
}
