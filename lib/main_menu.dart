import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'Components/pixelized_stadium_border.dart';

Widget PauseMenu(FlameGame game) {
  return Container(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () =>
                {game.overlays.remove("PauseMenu"), game.resumeEngine()},
            style: ButtonStyle(
                shape: WidgetStatePropertyAll<PixelizedStadiumBorder>(
                    PixelizedStadiumBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.cyan, width: 3.0),
                        pixelRadius: 20.0,
                        pixelSize: 5.0))),
            child: const Text("Resume"),
          ),
          ElevatedButton(
            onPressed: () => {
              game.overlays.remove("PauseMenu"),
            },
            style: ButtonStyle(
                shape: WidgetStatePropertyAll<PixelizedStadiumBorder>(
                    PixelizedStadiumBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.cyan, width: 3.0),
                        pixelRadius: 20.0,
                        pixelSize: 5.0))),
            child: const Text("Задачи"),
          )
        ],
      ));
}
