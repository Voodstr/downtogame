import 'package:downtogame/Components/Components.dart';
import 'package:flame/components.dart';

import '../assets.dart';

class Ground extends SurfaceObject {
  Ground({super.position, super.animations})
      : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
          objDefaultImage: Assets.assets_default_ground_png,
          objIdleImage: Assets.assets_default_ground_png,
          objWaveImage: Assets.assets_default_ground_wave_png,
          slow: 2.0,
        );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      current = SurfaceState.wave;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    current = SurfaceState.idle;
    super.onCollisionEnd(other);
  }
}
