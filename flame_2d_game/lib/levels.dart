import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_2d_game/background.dart';
import 'package:flame_2d_game/characters/player.dart';
import 'package:flame_2d_game/checkpoint.dart';
import 'package:flame_2d_game/collision_block.dart';
import 'package:flame_2d_game/fruit.dart';
import 'package:flame_2d_game/my_game.dart';
import 'package:flame_2d_game/saw.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<MyGame> {
  Level({required this.levelName, required this.player});
  late final String levelName;
  late TiledComponent level;
  late Player player;
  List<CollisionBlock> collisionBlocks = [];
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));
    // level.anchor = Anchor.center;
    add(level);
    _spwanObjects();
    _addCollisionBlocks();
    _scrollBackground();
    player.collisionBlocks = collisionBlocks;
    return super.onLoad();
  }

  void _spwanObjects() {
    final palyerSpawnPoint = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');
    if (palyerSpawnPoint != null) {
      for (var spawnPoint in palyerSpawnPoint.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          case 'Fruit':
            final fruit = Fruit(
                fruitName: spawnPoint.name,
                position: Vector2(spawnPoint.x, spawnPoint.y),
                size: Vector2(spawnPoint.width, spawnPoint.height));
            add(fruit);
            break;
          case 'Saw':
            final saw = Saw(
                isVertical: spawnPoint.properties.getValue('isVertical'),
                offNeg: spawnPoint.properties.getValue('offNeg'),
                offPos: spawnPoint.properties.getValue('offPos'),
                position: Vector2(spawnPoint.x, spawnPoint.y),
                size: Vector2(spawnPoint.width, spawnPoint.height));
            add(saw);
            break;
          case 'Checkpoint':
            final checkPoint = CheckPoint(
                position: Vector2(spawnPoint.x, spawnPoint.y),
                size: Vector2(spawnPoint.width, spawnPoint.height));
            add(checkPoint);
            break;
          default:
        }
      }
    }
  }

  void _addCollisionBlocks() {
    final collisions = level.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisions != null) {
      for (var collision in collisions.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
                position: Vector2(collision.x, collision.y),
                size: Vector2(collision.width, collision.height),
                isPlatform: true);
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
                position: Vector2(collision.x, collision.y),
                size: Vector2(collision.width, collision.height));
            collisionBlocks.add(block);
            add(block);
        }
      }
    }
  }

  void _scrollBackground() {
    final backgroundLayer = level.tileMap.getLayer('Background');

    if (backgroundLayer != null) {
      final backgroundColor =
          backgroundLayer.properties.getValue('BackgroundColor');
      final backgroundtile = BackgroundTile(
          color: backgroundColor ?? 'Gray', position: Vector2(0, 0));
      add(backgroundtile);
    }
  }
}
