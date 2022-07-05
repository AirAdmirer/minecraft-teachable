import 'package:flame/components.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/player_data.dart';
import 'package:minecraft/resources/hostile_entity.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';

class Spider extends HostileEntity {
  Spider({required super.spawnIndexPosition})
      : super(
          path: "sprite_sheets/mobs/sprite_sheet_spider.png",
          srcSize: Vector2(131, 60),
        ) {
    doFallDamage = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    fallingLogic(dt);
    killEntityLogic();
    jumpingLogic();
    checkForAggrevation();
    spiderLogic(dt);
    animationLogic();
    despawnLogic();

    setAllCollisionToFalse();
  }

  void spiderLogic(double dt) {
    if (isAggrevated) {
      double playerXPosition =
          GlobalGameReference.instance.gameReference.playerComponent.position.x;

      if ((playerXPosition - position.x).abs() > 10) {
        //if to the left
        if (position.x < playerXPosition) {
          //Move to the right
          if (!move(ComponentMotionState.walkingRight, dt,
              ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3)) {
            jumpForce += GameMethods.instance.blockSize.x * 0.25;
          }

          //move to the left
        } else {
          if (!move(ComponentMotionState.walkingLeft, dt,
              ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3)) {
            jumpForce += GameMethods.instance.blockSize.x * 0.25;
          }
        }
      }
    }
  }

  @override
  void onGameResize(Vector2 newScreenSize) {
    super.onGameResize(newScreenSize);

    size = srcSize * ((GameMethods.instance.blockSize.y) / srcSize.y);
  }
}
