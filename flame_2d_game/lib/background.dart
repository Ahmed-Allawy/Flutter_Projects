import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_2d_game/my_game.dart';

class BackgroundTile extends SpriteComponent with HasGameRef<MyGame> {
  final String color;
  BackgroundTile({this.color = 'Gray', position}) : super(position: position);
  final scrolleSpeed = 0.5;
  @override
  FutureOr<void> onLoad() {
    priority = -2;
    size = Vector2.all(64.4);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += scrolleSpeed;
    const tileSize = 64.0;
    final tileHeight = (game.size.y / tileSize).floor();
    if (position.y > tileHeight * tileSize) {
      position.y = 1;
    }
    super.update(dt);
  }
}
