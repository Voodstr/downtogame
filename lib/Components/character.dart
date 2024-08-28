import 'package:downtogame/Components/components.dart';
import 'package:downtogame/downtogame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../assets.dart';

class Character extends SpriteAnimationGroupComponent<CharacterState>
    with CollisionCallbacks, HasGameRef<DownToGame> {
  Character(
      {super.position,
      super.animations,
      required this.moveSpeed,
      required Anchor anchor,
      required this.charDefaultImage,
      required this.charIdleImage,
      required this.charRunningImage,
      required Vector2 size})
      : super(size: size, anchor: anchor, current: CharacterState.idle);

  int horizontalDirection = 0;
  int verticalDirection = 0;
  bool isInWall = false;
  final Vector2 velocity = Vector2.zero();
  double defaultMS = 300;
  double moveSpeed = 300;
  double stepTime = 0.2;
  String charDefaultImage = Assets.assets_default_player_0_png;
  String charIdleImage = Assets.assets_default_player_1_png;
  String charRunningImage = Assets.assets_default_player_run_png;

  @override
  void update(double dt) {
    velocity.x = horizontalDirection * moveSpeed;
    velocity.y = verticalDirection * moveSpeed;
    position += velocity * dt;
    if (isInWall) {
      velocity.x = 0;
      velocity.y = 0;
    }
    animations?.entries.first.value.stepTime = 50/moveSpeed;
    animations?.entries.last.value.stepTime = 50/moveSpeed*30;
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SolidObject) {
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
    if (other is SurfaceObject) {
      moveSpeed = defaultMS * other.slow;
      stepTime = 50 / moveSpeed;
      other.current = SurfaceState.wave;
    }
    if (other is Entrance) {
      game.world.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Ground) {
      moveSpeed = defaultMS;
      stepTime = 50 / moveSpeed;
    }
    super.onCollisionEnd(other);
  }

  @override
  Future<void> onLoad() async {
    final characterImage0 = game.images.fromCache(
      charDefaultImage,
    );
    final characterImage1 = game.images.fromCache(
      charIdleImage,
    );
    final characterImage2 = game.images.fromCache(
      charRunningImage,
    );
    var characterRunning = SpriteAnimation.spriteList(
      [Sprite(characterImage0), Sprite(characterImage2)],
      stepTime: stepTime,
    );
    var characterIdle = SpriteAnimation.spriteList(
      [Sprite(characterImage0), Sprite(characterImage1)],
      stepTime: stepTime*100,
    );
    animations = {
      CharacterState.running: characterRunning,
      CharacterState.idle: characterIdle
    };
    add(CircleHitbox());
  }
}

enum CharacterState {
  idle,
  running,
}
