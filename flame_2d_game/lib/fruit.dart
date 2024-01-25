import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_2d_game/my_game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'custom_hitbox.dart';

class Fruit extends SpriteAnimationComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  final String fruitName;
  Fruit({position, size, this.fruitName = 'Apple'})
      : super(position: position, size: size);
  final CustomHitBox hitbox =
      CustomHitBox(offsetX: 10, offsetY: 10, width: 12, height: 12);
  @override
  FutureOr<void> onLoad() {
    priority = -1;
    // debugMode = true;
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/$fruitName.png'),
        SpriteAnimationData.sequenced(
            amount: 17, stepTime: 0.05, textureSize: Vector2.all(32)));
    add(RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
        collisionType: CollisionType.passive));
    return super.onLoad();
  }

  void collisionWithPlayer() async {
    if (game.playSounds) {
      FlameAudio.play('collect_fruit.wav', volume: game.soundVolume);
    }
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/Collected.png'),
        SpriteAnimationData.sequenced(
            amount: 17,
            stepTime: 0.05,
            textureSize: Vector2.all(32),
            loop: false));
    await animationTicker?.completed;
    removeFromParent();
  }
}
