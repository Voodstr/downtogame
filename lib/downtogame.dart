import 'dart:ui';

import 'package:downtogame/Components/components.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'assets.dart';

class DownToGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, ScrollDetector, TapDetector, DoubleTapDetector   {
  DownToGame() : _world = DownToWorld() {
    cameraComponent = CameraComponent(world: _world);
    images.prefix = '';
  }

  // Inside your game:
  final pauseOverlayIdentifier = 'PauseMenu';


  late double startZoom;
  static const zoomPerScrollUnit = 0.5;

  void clampZoom() {
    cameraComponent.viewfinder.zoom = cameraComponent.viewfinder.zoom.clamp(0.5, 2.0);
  }

  @override
  void onScroll(PointerScrollInfo info) {
    cameraComponent.viewfinder.zoom +=
        info.scrollDelta.global.y.sign * zoomPerScrollUnit;
    clampZoom();
  }


  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 121, 63, 33);
  }

  late final CameraComponent cameraComponent;
  final DownToWorld _world;

  final regular = TextPaint();

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      Assets.assets_default_player_0_png,
      Assets.assets_default_player_1_png,
      Assets.assets_default_player_2_png,
      Assets.assets_default_ground_png,
      Assets.assets_default_wall_png,
    ]);
    cameraComponent.viewfinder.anchor = Anchor.center;
    add(cameraComponent);
    add(_world);
    cameraComponent.follow(_world.player);
  }
}



Widget _pauseMenuBuilder(BuildContext buildContext, DownToGame game) {
  return Center(
    child: Container(
      width: 100,
      height: 100,
      color: Colors.orange,
      child: const Center(
        child: Text('Paused'),
      ),
    ),
  );
}

Widget overlayBuilder(BuildContext ctx) {
  return GameWidget<DownToGame>(
    game: DownToGame()
      ..paused = true,
    overlayBuilderMap: const {
      'PauseMenu': _pauseMenuBuilder,
    },
    initialActiveOverlays: const ['PauseMenu'],
  );
}
