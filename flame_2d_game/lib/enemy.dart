import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_2d_game/characters/player.dart';
import 'package:flame_2d_game/my_game.dart';
import 'package:flame_audio/flame_audio.dart';

enum EnemyState { idle, running, hit, disappearing }

enum MoveDirection { positive, negative }

class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  final String enemyName;
  final double offNeg;
  final double offPos;
  Enemy({position, size, this.enemyName = '', this.offNeg = 0, this.offPos = 0})
      : super(position: position, size: size);
  late Player player;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation hitAnimation;
  late SpriteAnimation disappearingAnimation;
  final double moveSpeed = 50;
  final int tileSize = 16;
  double rangePos = 0;
  double rangeNeg = 0;
  MoveDirection moveDir = MoveDirection.positive;
  bool isHit = false;
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    _calculateRanges();
    add(RectangleHitbox(position: Vector2(10, 5), size: Vector2(13, 26)));
    player = game.player;
    return super.onLoad();
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runAnimation = _spriteAnimation('Run', 12);
    hitAnimation = _spriteAnimation('Hit', 7)..loop = false;
    disappearingAnimation = _spetialSpriteAnimation('Desappearing', 7);
    animations = {
      EnemyState.idle: idleAnimation,
      EnemyState.running: runAnimation,
      EnemyState.hit: hitAnimation,
      EnemyState.disappearing: disappearingAnimation
    };
    current = EnemyState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Main Characters/$enemyName/$state (32x32).png'),
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

  @override
  void update(double dt) {
    if (!isHit) {
      _moveEnemy(dt);
    }

    super.update(dt);
  }

  void _calculateRanges() {
    rangePos = position.x + tileSize * offPos;
    rangeNeg = position.x - tileSize * offNeg;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      if (player.velocity.y > 0 && player.y + player.height > position.y) {
        isHit = true;
        player.bouncePlayer();
        _disappearingEnemy();
      } else {
        player.collidedwithEnemy();
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  void _disappearingEnemy() async {
    if (game.playSounds) {
      FlameAudio.play('bounce.wav', volume: game.soundVolume);
    }
    current = EnemyState.hit;
    await animationTicker?.completed;
    current = EnemyState.disappearing;
    await animationTicker?.completed;
    removeFromParent();
  }

  void _moveEnemy(double dt) {
    // palyer in range
    if (player.y > position.y && player.x >= rangeNeg && player.x <= rangePos) {
      current = EnemyState.running;
      // just moving
      if (moveDir == MoveDirection.positive) {
        position.x += moveSpeed * dt;
      } else {
        position.x -= moveSpeed * dt;
      }
    } else {
      current = EnemyState.idle;
    }

// determine direction of moving
    if (position.x > player.x) {
      if (moveDir == MoveDirection.positive) {
        flipHorizontallyAroundCenter();
      }
      moveDir = MoveDirection.negative;
    }
    if (position.x < player.x) {
      if (moveDir == MoveDirection.negative) {
        flipHorizontallyAroundCenter();
      }
      moveDir = MoveDirection.positive;
    }
  }
}
