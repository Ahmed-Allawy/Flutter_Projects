import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_2d_game/my_game.dart';

class BackgroundTile extends SpriteComponent with HasGameRef<MyGame> {
  final String color;
  BackgroundTile({this.color = 'Gray', position}) : super(position: position);

  @override
  FutureOr<void> onLoad() {
    size = Vector2.all(64);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    return super.onLoad();
  }
}
