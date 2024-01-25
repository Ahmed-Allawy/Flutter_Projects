import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_2d_game/my_game.dart';

class JumpButton extends SpriteComponent with HasGameRef<MyGame>, TapCallbacks {
  JumpButton();
  @override
  FutureOr<void> onLoad() {
    priority = 3;
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    position = Vector2(game.size.x - 32 - 64, game.size.y - 32 - 64);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;
    super.onTapDown(event);
  }
}
