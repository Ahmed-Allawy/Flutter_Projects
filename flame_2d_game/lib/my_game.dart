import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_2d_game/characters/player.dart';
import 'package:flame_2d_game/jump_button.dart';
import 'package:flame_2d_game/levels.dart';
import 'package:flutter/painting.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  late CameraComponent cam;
  late Player player;
  late final JoystickComponent joystick;
  bool isPC = true;
  bool playSounds = true;
  double soundVolume = 0.5;
  List<String> allLevelsNames = ['Level-01', 'Level-02', 'Level-03'];
  int currentLevelIndex = 0;
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    _loadLevel();
    if (!isPC) {
      _addJoystick();
      add(JumpButton());
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

  void loadNextLevel() {
    removeWhere((component) => component is Level);
    if (currentLevelIndex < allLevelsNames.length - 1) {
      currentLevelIndex++;
      _loadLevel();
    } else {
      currentLevelIndex = 0;
      _loadLevel();
    }
  }

  void _loadLevel() {
    player = Player(characterName: 'Mask Dude');
    Level level =
        Level(levelName: allLevelsNames[currentLevelIndex], player: player);
    cam = CameraComponent.withFixedResolution(
        width: 640, height: 368, world: level);
    cam.viewfinder.anchor = Anchor.topLeft;
    level.priority = 2;
    cam.priority = 1;
    addAll([cam, level]);
  }
}
