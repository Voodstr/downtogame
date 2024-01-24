import 'package:downtogame/downtogame.dart';
import 'package:flame/components.dart';
import 'package:downtogame/Components/components.dart';
import 'package:downtogame/assets.dart';

class DownToWorld extends World with HasGameRef<DownToGame> {
  DownToWorld({super.children});

  final List<SpriteComponent> dungeon = [];
  late final Player player;

  static Vector2 size = Vector2.all(640);

  @override
  Future<void> onLoad() async {
    final groundImage = game.images.fromCache(
      Assets.assets_default_ground_png,
    );
    dungeon.add(
      Ground(position: Vector2.all(-64), sprite: Sprite(groundImage)),
    );
    final wallImage = game.images.fromCache(
      Assets.assets_default_wall_png,
    );
    dungeon.add(
      Wall(position: Vector2.all(0), sprite: Sprite(wallImage)),
    );
    dungeon.add(
      Wall(position: Vector2(64, -64), sprite: Sprite(wallImage)),
    );
    addAll(dungeon);
    final playerImage = game.images.fromCache(
      Assets.assets_default_player_png,
    );
    player = Player(position: Vector2.all(64), sprite: Sprite(playerImage));
    add(player);
  }
}
