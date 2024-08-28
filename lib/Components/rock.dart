import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../assets.dart';
import '../downtogame.dart';

class Rock extends SpriteComponent
    with HasGameRef<DownToGame>, CollisionCallbacks {
  Rock({super.position, super.sprite})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final wallImage = game.images.fromCache(
      Assets.assets_default_wall_png,
    );
    sprite = Sprite(wallImage);
    add(RectangleHitbox.relative(Vector2(1, 0.5),
        parentSize: size, anchor: Anchor.topCenter));
  }
}
