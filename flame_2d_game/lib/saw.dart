import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_2d_game/my_game.dart';

enum MoveDirection { positive, negative }

class Saw extends SpriteAnimationComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  Saw(
      {this.isVertical = false,
      this.offNeg = 0,
      this.offPos = 0,
      position,
      size})
      : super(position: position, size: size);
  final bool isVertical;
  final double offNeg;
  final double offPos;
  final double moveSpeed = 50;
  final int tileSize = 16;
  double rangePos = 0;
  double rangeNeg = 0;
  MoveDirection moveDir = MoveDirection.positive;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    // debugMode = true;
    _moveRanges();

    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Traps/Saw/On (38x38).png'),
        SpriteAnimationData.sequenced(
            amount: 8, stepTime: 0.03, textureSize: Vector2.all(38)));
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _moveSaw(dt);

    super.update(dt);
  }

  void _moveRanges() {
    if (isVertical) {
      rangePos = position.y + tileSize * offPos;
      rangeNeg = position.y - tileSize * offNeg;
    } else {
      rangePos = position.x + tileSize * offPos;
      rangeNeg = position.x - tileSize * offNeg;
    }
  }

  void _moveHorizontal(double dt) {
    // just moving saw
    if (moveDir == MoveDirection.positive) {
      position.x += moveSpeed * dt;
    } else {
      position.x -= moveSpeed * dt;
    }
// determine direction of moving
    if (position.x >= rangePos) {
      moveDir = MoveDirection.negative;
    }
    if (position.x <= rangeNeg) {
      moveDir = MoveDirection.positive;
    }
  }

  void _moveVertical(double dt) {
    // just moving saw
    if (moveDir == MoveDirection.positive) {
      position.y += moveSpeed * dt;
    } else {
      position.y -= moveSpeed * dt;
    }
// determine direction of moving
    if (position.y >= rangePos) {
      moveDir = MoveDirection.negative;
    }
    if (position.y <= rangeNeg) {
      moveDir = MoveDirection.positive;
    }
  }

  void _moveSaw(double dt) {
    if (isVertical) {
      _moveVertical(dt);
    } else {
      _moveHorizontal(dt);
    }
  }
}
