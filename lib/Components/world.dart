import 'package:downtogame/downtogame.dart';
import 'package:flame/components.dart';
import 'package:downtogame/Components/components.dart';

class DownToWorld extends World with HasGameRef<DownToGame> {
  DownToWorld({super.children});

  final List<SpriteComponent> dungeon = [];
  late final Player player;
  List<List<bool>> groundLevel = [
    [false, true, false],
    [true, true, true],
    [false, true, false]
  ];

  static Vector2 size = Vector2.all(640);

  void loadImages() {}

  @override
  Future<void> onLoad() async {
    for (int i = 0; i<groundLevel.length; i++) {
      for (int k = 0; k < groundLevel.length; k++) {
        if(groundLevel.elementAt(i).elementAt(k)==true){
          dungeon.add(
            Ground(position: Vector2(i * 64, k * 64)),
          );
        }
      }
    }
    dungeon.add(
      Wall(position: Vector2(-64, 0)),
    );
    dungeon.add(
      Wall(position: Vector2(64, -64)),
    );
    addAll(dungeon);
    player = Player(position: Vector2.all(64));
    add(player);
  }
}
