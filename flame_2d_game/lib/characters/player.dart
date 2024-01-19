import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';

import '../my_game.dart';

enum PlayerState { idle, running, fall, hit, jump }

enum PlayerDirection { right, left, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<MyGame>, KeyboardHandler {
  Player({position, this.characterName = 'Mask Dude'})
      : super(position: position);
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation fallAnimation;
  late SpriteAnimation hitAnimation;
  late SpriteAnimation jumpAnimation;
  late String characterName;
  final double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  PlayerDirection playerDirection = PlayerDirection.none;
  bool isFaceRight = true;
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerPosition(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    if (isRightKeyPressed && isLeftKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else {
      playerDirection = PlayerDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runAnimation = _spriteAnimation('Run', 12);
    fallAnimation = _spriteAnimation('Fall', 1);
    jumpAnimation = _spriteAnimation('Jump', 1);
    hitAnimation = _spriteAnimation('Hit', 7);
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.jump: jumpAnimation,
      PlayerState.fall: fallAnimation,
    };
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images
            .fromCache('Main Characters/$characterName/$state (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: 0.05, textureSize: Vector2.all(32)));
  }

  void _updatePlayerPosition(double dt) {
    double dx = 0.0;
    switch (playerDirection) {
      case PlayerDirection.right:
        if (!isFaceRight) {
          flipHorizontallyAroundCenter();
          isFaceRight = true;
        }
        current = PlayerState.running;
        dx += moveSpeed;
        break;
      case PlayerDirection.left:
        if (isFaceRight) {
          flipHorizontallyAroundCenter();
          isFaceRight = false;
        }
        current = PlayerState.running;
        dx -= moveSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
      default:
    }
    velocity = Vector2(dx, 0.0);
    position += velocity * dt;
  }
}
