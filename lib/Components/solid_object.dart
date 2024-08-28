import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../assets.dart';
import '../downtogame.dart';

/// Неподвижный анимированный объект, через который нельзя пройти
//
class SolidObject extends SpriteAnimationGroupComponent<SolidState>
    with CollisionCallbacks, HasGameRef<DownToGame> {
  SolidObject(
      {super.position,
      super.animations,
      required Anchor anchor,
      required this.objDefaultImage,
      required this.objWaveImage,
      required this.objIdleImage,
      required Vector2 size})
      : super(size: size, anchor: anchor, current: SolidState.idle);

  String objDefaultImage = Assets.assets_default_player_0_png;
  String objIdleImage = Assets.assets_default_player_0_png;
  String objWaveImage = Assets.assets_default_player_1_png;
  double stepTime = 10; // animation time - 1 image time default 0.1 sec

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
    var objIdle =
        SpriteAnimation.spriteList([Sprite(objImage1)], stepTime: stepTime);
    var objWeaving = SpriteAnimation.spriteList(
      [Sprite(objImage0), Sprite(objImage2)],
      stepTime: stepTime * 100,
    );
    animations = {SolidState.wave: objWeaving, SolidState.idle: objIdle};
    add(CircleHitbox());
  }
}

enum SolidState { idle, wave }
