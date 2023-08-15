import 'package:flame/components.dart';

import '../downtogame.dart';

class Ground extends SpriteComponent with HasGameRef<DownToGame> {
  Ground({super.position, super.sprite})
      : super(size: Vector2.all(64), anchor: Anchor.center);
}
