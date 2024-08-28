import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:downtogame/Components/components.dart';

import '../assets.dart';

class Wall extends SolidObject {
  Wall({super.position, super.animations})
      : super(
            size: Vector2.all(64),
            anchor: Anchor.center,
            objWaveImage: Assets.assets_default_wall_png,
            objIdleImage: Assets.assets_default_wall_png,
            objDefaultImage: Assets.assets_default_wall_png);
}
