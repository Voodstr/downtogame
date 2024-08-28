
import 'package:downtogame/Components/components.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'assets.dart';

class DownToGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, ScrollDetector, TapDetector, DoubleTapDetector   {
  DownToGame() : _world = DownToWorld() {
    cameraComponent = CameraComponent(world: _world);
    images.prefix = '';
  }

  //Не забыть обновить
  var assetsList = [
    Assets.assets_default_player_0_png,
    Assets.assets_default_player_1_png,
    Assets.assets_default_player_run_png,
    Assets.assets_default_ground_png,
    Assets.assets_default_wall_png,
    Assets.assets_default_entrance_png,
    Assets.assets_default_ground_wave_png
  ];
  // Inside your game:
  final pauseOverlayIdentifier = 'PauseMenu';


  late double startZoom;
  static const zoomPerScrollUnit = 0.25;

  void clampZoom() {
    cameraComponent.viewfinder.zoom =
        cameraComponent.viewfinder.zoom.clamp(0.25, 1.0);
  }

  // было бы интересно сделать отдаление как навык для разведки. т.к. сжатое пространство это ощущение ограничения и внезапности
  @override
  void onScroll(PointerScrollInfo info) {
    cameraComponent.viewfinder.zoom +=
        info.scrollDelta.global.y.sign * zoomPerScrollUnit;
    clampZoom();
  }

  /*@override
  Color backgroundColor() {
    return const Color.fromARGB(255, 121, 63, 33);
  }

   */

  late final CameraComponent cameraComponent;
  final DownToWorld _world;

  final regular = TextPaint();

  @override
  Future<void> onLoad() async {
    await images.loadAll(assetsList);
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
      'AchievementMenu': _pauseMenuBuilder,
    },
    initialActiveOverlays: const ['PauseMenu'],
  );
}
