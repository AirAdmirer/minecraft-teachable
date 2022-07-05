import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/player_data.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/entity.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';

class PlayerComponent extends Entity {
  final Vector2 playerDimensions = Vector2.all(60);

  final double stepTime = 0.3;

  late SpriteSheet playerWalkingSpritesheet;
  late SpriteSheet playerIdleSpritesheet;

  late SpriteAnimation walkingAnimation =
      playerWalkingSpritesheet.createAnimation(row: 0, stepTime: stepTime);

  late SpriteAnimation walkingHurtAnimation =
      playerWalkingSpritesheet.createAnimation(row: 1, stepTime: stepTime);

  late SpriteAnimation idleAnimation =
      playerIdleSpritesheet.createAnimation(row: 0, stepTime: stepTime);

  late SpriteAnimation idleHurtAnimation =
      playerIdleSpritesheet.createAnimation(row: 1, stepTime: stepTime);

  double localPlayerSpeed = 0;

  bool refreshSpeed = false;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BlockComponent &&
        BlockData.getBlockDataFor(other.block).isCollidable) {
      super.onCollision(intersectionPoints, other);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    GlobalGameReference.instance.gameReference.camera.followComponent(this);

    await Future.delayed(Duration(seconds: 1));

    health = GlobalGameReference
        .instance.gameReference.worldData.playerData.playerHealth.value;

    add(RectangleHitbox());

    priority = 2;

    anchor = Anchor.bottomCenter;

    playerWalkingSpritesheet = SpriteSheet(
        image: Flame.images
            .fromCache("sprite_sheets/player/player_walking_sprite_sheet.png"),
        srcSize: playerDimensions);

    playerIdleSpritesheet = SpriteSheet(
        image: Flame.images
            .fromCache("sprite_sheets/player/player_idle_sprite_sheet.png"),
        srcSize: playerDimensions);

    position = Vector2(100, 400);

    animation = idleAnimation;

    add(TimerComponent(
        period: 1,
        repeat: true,
        onTick: () {
          refreshSpeed = true;
        }));

    add(TimerComponent(
        period: 25,
        repeat: true,
        onTick: () {
          changeHungerBy(-1);
        }));

    position = GameMethods.instance.getSpawnPositionForPlayer() *
        GameMethods.instance.blockSize.x;
  }

  @override
  void update(double dt) {
    super.update(dt);
    movementLogic(dt);
    fallingLogic(dt);
    jumpingLogic();
    killEntityLogic();
    healthAndHungerLogic();
    setAllCollisionToFalse();

    //changing our speed
    if (refreshSpeed) {
      double hunger = GlobalGameReference
          .instance.gameReference.worldData.playerData.playerHunger.value;
      if (hunger > 3) {
        localPlayerSpeed =
            (playerSpeed * GameMethods.instance.blockSize.x) * dt;
      } else {
        localPlayerSpeed =
            (playerSpeed * GameMethods.instance.blockSize.x) * dt;

        localPlayerSpeed /= 2;
      }
      refreshSpeed = false;
    }

    double playerHealth = GlobalGameReference
        .instance.gameReference.worldData.playerData.playerHealth.value;

    if (playerHealth != health) {
      GlobalGameReference.instance.gameReference.worldData.playerData
          .playerHealth.value = health;
    }
  }

  void changeHungerBy(double value) {
    //currentHunger
    double hunger = GlobalGameReference
        .instance.gameReference.worldData.playerData.playerHunger.value;

    if (hunger + value <= 10) {
      if (hunger + value >= 0) {
        GlobalGameReference.instance.gameReference.worldData.playerData
            .playerHunger.value += value;
      } else {
        GlobalGameReference
            .instance.gameReference.worldData.playerData.playerHunger.value = 0;
      }
    } else {
      GlobalGameReference
          .instance.gameReference.worldData.playerData.playerHunger.value = 10;
    }
  }

  void healthAndHungerLogic() {
    //regeneraitionLogic
    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.playerHunger.value >
        9) {
      changeHealthBy(0.075);
    }
  }

  void movementLogic(double dt) {
    //Moving left
    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.walkingLeft) {
      if (move(ComponentMotionState.walkingLeft, dt, localPlayerSpeed)) {
        GlobalGameReference.instance.gameReference.skyComponent
            .componentMotionState = ComponentMotionState.walkingRight;
      } else {
        GlobalGameReference.instance.gameReference.skyComponent
            .componentMotionState = ComponentMotionState.idle;
      }
      if (isHurt) {
        animation = walkingHurtAnimation;
      } else {
        animation = walkingAnimation;
      }
    }

    //Moving right
    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.walkingRight) {
      if (move(ComponentMotionState.walkingRight, dt, localPlayerSpeed)) {
        GlobalGameReference.instance.gameReference.skyComponent
            .componentMotionState = ComponentMotionState.walkingLeft;
      } else {
        GlobalGameReference.instance.gameReference.skyComponent
            .componentMotionState = ComponentMotionState.idle;
      }
      if (isHurt) {
        animation = walkingHurtAnimation;
      } else {
        animation = walkingAnimation;
      }
    }
    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.idle) {
      if (isHurt) {
        animation = idleHurtAnimation;
      } else {
        animation = idleAnimation;
      }
      GlobalGameReference.instance.gameReference.skyComponent
          .componentMotionState = ComponentMotionState.idle;
    }
    if (GlobalGameReference.instance.gameReference.worldData.playerData
                .componentMotionState ==
            ComponentMotionState.jumping &&
        isCollidingBottom) {
      jump();
    }
  }

  @override
  void onGameResize(Vector2 newGameSize) {
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize * 1.5;
  }

  @override
  void onRemove() {
    super.onRemove();

    GlobalGameReference
        .instance.gameReference.worldData.playerData.playerIsDead.value = true;
  }
}
