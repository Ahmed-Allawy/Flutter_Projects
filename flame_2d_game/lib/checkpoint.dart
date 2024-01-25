import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_2d_game/characters/player.dart';
import 'package:flame_2d_game/my_game.dart';

class CheckPoint extends SpriteAnimationComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  CheckPoint({position, size}) : super(position: position, size: size);
  bool reachedCheckpoint = false;
  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    animation = SpriteAnimation.fromFrameData(
        game.images
            .fromCache('Items/Checkpoints/Checkpoint/Checkpoint (No Flag).png'),
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 1, textureSize: Vector2.all(64)));
    add(RectangleHitbox(position: Vector2(20, 20), size: Vector2(7, 40)));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player && !reachedCheckpoint) {
      _reachedCheckpoint();
    }
    super.onCollision(intersectionPoints, other);
  }

  void _reachedCheckpoint() {
    reachedCheckpoint = true;
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Items/Checkpoints/Checkpoint/Checkpoint (Flag Out) (64x64).png'),
        SpriteAnimationData.sequenced(
            amount: 26,
            stepTime: 0.05,
            textureSize: Vector2.all(64),
            loop: false));
    const flagIdleDelay = Duration(milliseconds: 400);
    Future.delayed(flagIdleDelay, () {
      animation = SpriteAnimation.fromFrameData(
          game.images.fromCache(
              'Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png'),
          SpriteAnimationData.sequenced(
            amount: 10,
            stepTime: 0.05,
            textureSize: Vector2.all(64),
          ));
    });
  }
}
