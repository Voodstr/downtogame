import 'dart:ui';

import 'package:downtogame/Components/components.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'assets.dart';

class DownToGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  DownToGame() : _world = DownToWorld() {
    cameraComponent = CameraComponent(world: _world);
    images.prefix = '';
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 121, 63, 33);
  }

  late final CameraComponent cameraComponent;
  final DownToWorld _world;

  @override
  Future<void> onLoad() async {
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
