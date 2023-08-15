import 'package:downtogame/Components/components.dart';
import 'package:downtogame/downtogame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Character extends SpriteComponent
    with CollisionCallbacks, HasGameRef<DownToGame> {
  Character(
      {super.position,
      super.sprite,
      required Anchor anchor,
      required Vector2 size})
      : super(
          size: size,
          anchor: anchor,
        );

  int horizontalDirection = 0;
  int verticalDirection = 0;
  bool isInWall = false;
  final Vector2 velocity = Vector2.zero();
  double moveSpeed = 200;

  @override
  void update(double dt) {
    velocity.x = horizontalDirection * moveSpeed;
    velocity.y = verticalDirection * moveSpeed;
    position += velocity * dt;
    if (isInWall) {
      velocity.x = 0;
      velocity.y = 0;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Wall) {
      if (intersectionPoints.length == 2) {
        // Calculate the collision normal and separation distance.
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;
        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 1.9) - collisionNormal.length;
        collisionNormal.normalize();
        isInWall = true;
        // Resolve collision by moving ember along
        // collision normal by separation distance.
        position += collisionNormal.scaled(separationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(
      CircleHitbox(),
    );
  }
}
