import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_2d_game/check_collision.dart';
import 'package:flame_2d_game/checkpoint.dart';
import 'package:flame_2d_game/custom_hitbox.dart';
import 'package:flame_2d_game/fruit.dart';
import 'package:flame_2d_game/saw.dart';
import 'package:flutter/services.dart';
import '../collision_block.dart';
import '../my_game.dart';
import 'package:flame_audio/flame_audio.dart';

enum PlayerState { idle, running, fall, hit, jump, appearing, disappearing }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<MyGame>, KeyboardHandler, CollisionCallbacks {
  Player({position, this.characterName = 'Mask Dude'})
      : super(position: position);
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation fallAnimation;
  late SpriteAnimation hitAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation appearingAnimation;
  late SpriteAnimation disappearingAnimation;
  late String characterName;
  int dx = 0;
  final double moveSpeed = 100;
  final double gravity = 20.8;
  final double jumpForce = 400;
  final double terminalYvelocity = 300;
  bool hasJumped = false;
  bool isGround = false;
  bool gotHit = false;
  bool reachedCheckpoint = false;
  Vector2 velocity = Vector2.zero();
  List<CollisionBlock> collisionBlocks = [];
  CustomHitBox hitBox =
      CustomHitBox(offsetX: 10, offsetY: 4, width: 13, height: 26);
  Vector2 startPosition = Vector2.zero();
  @override
  FutureOr<void> onLoad() {
    startPosition = Vector2(position.x, position.y);
    _loadAllAnimations();
    add(RectangleHitbox(
        position: Vector2(hitBox.offsetX, hitBox.offsetY),
        size: Vector2(hitBox.width, hitBox.height)));

    // debugMode = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!gotHit && !reachedCheckpoint) {
      _updatePlayerState();
      _updatePlayerPosition(dt);
      _checkHorizontalCollision();
      _applyGravity(dt);
      _checkVerticalCollision();
    }

    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    dx = 0;
    final isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    dx = isRightKeyPressed
        ? 1
        : isLeftKeyPressed
            ? -1
            : 0;

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (!reachedCheckpoint) {
      if (other is Fruit && !gotHit) {
        other.collisionWithPlayer();
      }
      if (other is Saw) {
        _respawn();
      }
      if (other is CheckPoint) {
        _reachedCheckpoint();
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runAnimation = _spriteAnimation('Run', 12);
    fallAnimation = _spriteAnimation('Fall', 1);
    jumpAnimation = _spriteAnimation('Jump', 1);
    hitAnimation = _spriteAnimation('Hit', 7)..loop = false;
    appearingAnimation = _spetialSpriteAnimation('Appearing', 7);
    disappearingAnimation = _spetialSpriteAnimation('Desappearing', 7);
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.jump: jumpAnimation,
      PlayerState.fall: fallAnimation,
      PlayerState.appearing: appearingAnimation,
      PlayerState.disappearing: disappearingAnimation
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

  SpriteAnimation _spetialSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Main Characters/$state (96x96).png'),
        SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: 0.05,
            textureSize: Vector2.all(96),
            loop: false));
  }

  void _updatePlayerPosition(double dt) {
    // horizontal position
    velocity.x = dx * moveSpeed;
    position.x += velocity.x * dt;

    // if (velocity.y > gravity) {
    //   isGround = false;
    // }
    //vertical position
    if (hasJumped && isGround) {
      if (game.playSounds)
        FlameAudio.play('jump.wav', volume: game.soundVolume);
      velocity.y = -jumpForce;
      position.y += velocity.y * dt;
      isGround = false;
      hasJumped = false;
    }
  }

  void _updatePlayerState() {
    // if (dx != 0) {
    //   current = PlayerState.running;
    // } else {
    //   current = PlayerState.idle;
    // }
    // if (velocity.y > 0) {
    //   playerState = PlayerState.fall;
    // } else if (velocity.y < 0) {
    //   playerState = PlayerState.jump;
    // } else if (dx != 0) {
    //   playerState = PlayerState.running;
    //   if (dx == -1 && isFaceRight == true) {
    //     flipHorizontallyAroundCenter();
    //     isFaceRight = false;
    //   }
    //   if (dx == 1 && isFaceRight == false) {
    //     flipHorizontallyAroundCenter();
    //     isFaceRight = true;
    //   }
    // } else {
    //   current = playerState;
    // }
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    // Check if moving, set running
    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;

    // check if Falling set to falling
    if (velocity.y > 0) playerState = PlayerState.fall;

    // Checks if jumping, set to jumping
    if (velocity.y < 0) playerState = PlayerState.jump;

    current = playerState;
  }

  void _checkHorizontalCollision() {
    for (var block in collisionBlocks) {
      if (!block.isPlatform) {
        if (isCollision(this, block)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitBox.width - hitBox.offsetX;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitBox.width + hitBox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += gravity;
    velocity.y = velocity.y.clamp(-jumpForce, terminalYvelocity);
    position.y += velocity.y * dt;
  }

  void _checkVerticalCollision() {
    for (var block in collisionBlocks) {
      if (!block.isPlatform) {
        if (isCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitBox.height - hitBox.offsetY;
            isGround = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height;
            isGround = true;
            break;
          }
        }
      } else {
        if (isCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitBox.height - hitBox.offsetY;
            isGround = true;
            break;
          }
        }
      }
    }
  }

  void _respawn() async {
    if (game.playSounds) FlameAudio.play('hit.wav', volume: game.soundVolume);
    const canMoveDelay = Duration(milliseconds: 400);
    gotHit = true;
    current = PlayerState.hit;
    await animationTicker?.completed;
    animationTicker?.reset();

    scale.x = 1;
    position = startPosition - Vector2.all(32);
    current = PlayerState.appearing;

    await animationTicker?.completed;
    animationTicker?.reset();

    velocity = Vector2.zero();
    position = startPosition;
    _updatePlayerState();
    Future.delayed(canMoveDelay, () => gotHit = false);
  }

  void _reachedCheckpoint() async {
    reachedCheckpoint = true;
    if (game.playSounds) {
      FlameAudio.play('disappear.wav', volume: game.soundVolume);
    }
    if (scale.x > 0) {
      position = position - Vector2.all(32);
    } else {
      position = position - Vector2(-32, 32);
    }
    current = PlayerState.disappearing;
    await animationTicker?.completed;
    reachedCheckpoint = true;
    position = Vector2.all(-600);
    const changeLevelDelay = Duration(seconds: 3);
    Future.delayed(changeLevelDelay, () {
      game.loadNextLevel();
    });
  }

  void collidedwithEnemy() {
    _respawn();
  }

  void bouncePlayer() {
    velocity.y = -260.0;
  }
}
