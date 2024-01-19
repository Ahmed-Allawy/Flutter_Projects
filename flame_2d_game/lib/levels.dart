import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_2d_game/characters/player.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  Level({required this.levelName, required this.player});
  late final String levelName;
  late TiledComponent level;
  late final Player player;
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));
    // level.anchor = Anchor.center;
    add(level);
    final palyerSpawnPoint = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');
    for (var spawnPoint in palyerSpawnPoint!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
