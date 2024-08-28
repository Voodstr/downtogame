import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../assets.dart';
import '../downtogame.dart';

/// Неподвижный анимированный объект - поверхность.
/// Влияет на скорость персонажа - slow - по умолчанию - 1.5 ускорение
class SurfaceObject extends SpriteAnimationGroupComponent<SurfaceState>
    with CollisionCallbacks, HasGameRef<DownToGame> {
  SurfaceObject(
      {super.position,
      super.animations,
      required Anchor anchor,
      required this.objDefaultImage,
      required this.objWaveImage,
      required this.objIdleImage,
      required Vector2 size,
      this.slow = 1.0,
      this.animationLoop = false})
      : super(size: size, anchor: anchor, current: SurfaceState.idle);

  String objDefaultImage = Assets.assets_default_player_0_png;
  String objIdleImage = Assets.assets_default_player_0_png;
  String objWaveImage = Assets.assets_default_player_1_png;
  double stepTime = 0.001; // animation time - 1 image time default 0.1 sec
  double slow = 1.0;
  bool animationLoop = false;

  @override
  Future<void> onLoad() async {
    final objImage0 = game.images.fromCache(
      objDefaultImage,
    );
    final objImage1 = game.images.fromCache(
      objIdleImage,
    );
    final objImage2 = game.images.fromCache(
      objWaveImage,
    );
    var objIdle = SpriteAnimation.spriteList(
        [Sprite(objImage1), Sprite(objImage0)],
        stepTime: stepTime);
    var objWeaving = SpriteAnimation.spriteList(
        [Sprite(objImage0), Sprite(objImage2)],
        stepTime: stepTime * 100, loop: animationLoop);
    animations = {SurfaceState.wave: objWeaving, SurfaceState.idle: objIdle};
    add(CircleHitbox());
  }
}

enum SurfaceState { idle, wave }
