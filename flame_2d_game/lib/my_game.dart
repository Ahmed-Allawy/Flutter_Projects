import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_2d_game/characters/player.dart';
import 'package:flame_2d_game/levels.dart';
import 'package:flutter/painting.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  late final CameraComponent cam;
  final Player player = Player(characterName: 'Mask Dude');
  late final JoystickComponent joystick;
  bool isPC = true;
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    final level = Level(levelName: 'Level-01', player: player);
    cam = CameraComponent.withFixedResolution(
        width: 640, height: 368, world: level);
    cam.viewfinder.anchor = Anchor.topLeft;
    level.priority = 2;
    cam.priority = 1;
    addAll([cam, level]);
    if (!isPC) {
      _addJoystick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!isPC) {
      _updateJoystick();
    }

    super.update(dt);
  }

  void _addJoystick() {
    joystick = JoystickComponent(
        knob: SpriteComponent(sprite: Sprite(images.fromCache('HUD/Knob.png'))),
        background: SpriteComponent(
            sprite: Sprite(images.fromCache('HUD/Joystick.png'))),
        margin: const EdgeInsets.only(left: 32, bottom: 32),
        priority: 3);
    add(joystick);
  }

  void _updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.dx = 1;
        break;
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.dx = -1;
        break;
      default:
        player.dx = 0;
    }
  }
}
