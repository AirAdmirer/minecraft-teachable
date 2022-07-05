import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/components/player_component.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/player_data.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/entity.dart';
import 'package:minecraft/resources/weapons.dart';
import 'package:minecraft/utils/game_methods.dart';

class HostileEntity extends Entity with Tappable {
  final String path;
  final Vector2 srcSize;
  final Vector2 spawnIndexPosition;

  HostileEntity(
      {required this.path,
      required this.srcSize,
      required this.spawnIndexPosition}) {
    GlobalGameReference.instance.gameReference.worldData.mobs.totalMobs++;
  }

  late SpriteSheet spriteSheet =
      SpriteSheet(image: Flame.images.fromCache(path), srcSize: srcSize);

  late SpriteAnimation walkingAnimation =
      spriteSheet.createAnimation(row: 2, stepTime: 0.2);

  late SpriteAnimation walkingHurtAnimation =
      spriteSheet.createAnimation(row: 3, stepTime: 0.2);

  late SpriteAnimation idleAnimation =
      SpriteAnimation.spriteList([spriteSheet.getSprite(0, 0)], stepTime: 0.2);

  late SpriteAnimation idleHurtAnimation =
      SpriteAnimation.spriteList([spriteSheet.getSprite(1, 0)], stepTime: 0.2);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //block collision
    if (other is BlockComponent &&
        BlockData.getBlockDataFor(other.block).isCollidable) {
      super.onCollision(intersectionPoints, other);
    }

    if (other is PlayerComponent) {
      inflictDamageToThePlayer(other);
    }
  }

  bool canJump = false;

  bool canDamage = false;

  bool isAggrevated = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    add(TimerComponent(
        period: 1,
        repeat: true,
        onTick: () {
          canJump = true;
        }));

    add(TimerComponent(
        period: .75,
        repeat: true,
        onTick: () {
          canDamage = true;
        }));

    anchor = Anchor.bottomCenter;

    animation = idleAnimation;

    position = spawnIndexPosition * GameMethods.instance.blockSize.x;
  }

  @override
  void update(double dt) {
    super.update(dt);
    animationLogic();
  }

  void inflictDamageToThePlayer(PlayerComponent other) {
    if (canDamage) {
      other.changeHealthBy(-1);
      canDamage = false;

      double playerXPosition =
          GlobalGameReference.instance.gameReference.playerComponent.position.x;
      other.move(
          position.x > playerXPosition
              ? ComponentMotionState.walkingLeft
              : ComponentMotionState.walkingRight,
          1 / 45,
          GameMethods.instance.blockSize.x * 0.6);
    }
  }

  void doKnockBackToSelf() {
    double playerXPosition =
        GlobalGameReference.instance.gameReference.playerComponent.position.x;

    move(
        position.x < playerXPosition
            ? ComponentMotionState.walkingLeft
            : ComponentMotionState.walkingRight,
        1 / 45,
        GameMethods.instance.blockSize.x * 0.6);
  }

  void checkForAggrevation() {
    if (GameMethods.instance.playerIsWithinRange(
        GameMethods.instance.getIndexPositionFromPixels(position))) {
      isAggrevated = true;
      animation = walkingAnimation;
    } else {
      isAggrevated = false;
      animation = idleAnimation;
    }
  }

  @override
  bool onTapDown(TapDownInfo info) {
    changeHealthBy(-getDamage().toDouble());
    doKnockBackToSelf();
    return true;
  }

  @override
  void onRemove() {
    super.onRemove();
    GlobalGameReference.instance.gameReference.worldData.mobs.totalMobs--;
    print("decrementing total mob count");
  }

  void animationLogic() {
    if (animation == walkingAnimation) {
      if (isHurt) {
        animation = walkingHurtAnimation;
      }
    } else if (animation == idleAnimation) {
      if (isHurt) {
        animation = idleHurtAnimation;
      }
    }
  }

  void despawnLogic() {
    int chunkIndex = GameMethods.instance.getChunkIndexFromPositionIndex(
        GameMethods.instance.getIndexPositionFromPixels(position));

    if (!GlobalGameReference
        .instance.gameReference.worldData.chunksThatShouldBeRendered
        .contains(chunkIndex)) {
      health = 0;
    }
  }
}
