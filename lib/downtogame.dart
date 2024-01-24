import 'dart:ui';

import 'package:downtogame/Components/components.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/services.dart';
import 'assets.dart';

class DownToGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, ScrollDetector {
  DownToGame() : _world = DownToWorld() {
    cameraComponent = CameraComponent(world: _world);
    images.prefix = '';
  }

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
    add(TextComponent(text: 'Hello, Flame', textRenderer: regular)
      ..anchor = Anchor.topCenter
      ..x = size.x / 2 // size is a property from game
      ..y = 32.0);
    await images.loadAll([
      Assets.assets_default_player_png,
      Assets.assets_default_ground_png,
      Assets.assets_default_wall_png,
    ]);
    cameraComponent.viewfinder.anchor = Anchor.center;
    add(cameraComponent);
    add(_world);
    cameraComponent.follow(_world.player);
  }
}
