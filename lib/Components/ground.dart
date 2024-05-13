import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../assets.dart';
import '../downtogame.dart';

class Ground extends SpriteComponent with HasGameRef<DownToGame> {
  Ground({super.position, super.sprite})
      : super(size: Vector2.all(64), anchor: Anchor.center);
  @override
  Future<void> onLoad() async {
    final groundImage = game.images.fromCache(
      Assets.assets_default_ground_png,
    );
    sprite = Sprite(groundImage);
    add(RectangleHitbox());
  }
}
