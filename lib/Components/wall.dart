import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../downtogame.dart';

class Wall extends SpriteComponent
    with HasGameRef<DownToGame>, CollisionCallbacks {
  Wall({super.position, super.sprite})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }
}
