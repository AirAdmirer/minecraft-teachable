import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:minecraft/global/player_data.dart';
import 'package:minecraft/utils/game_methods.dart';

class Entity extends SpriteAnimationComponent with CollisionCallbacks {
  bool isFacingRight = true;

  double yVelocity = 0;

  bool isCollidingBottom = false;
  bool isCollidingLeft = false;
  bool isCollidingRight = false;
  bool isCollidingTop = false;

  double jumpForce = 0;

  double health = 10;

  double blocksFallen = 0;

  bool isHurt = false;

  bool doFallDamage = true;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(TimerComponent(
        period: 0.5,
        repeat: true,
        onTick: () {
          isHurt = false;
        }));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    intersectionPoints.forEach((Vector2 individualIntersectionPoint) {
      //player is colliding with the ground

      //Ground collision
      if (individualIntersectionPoint.y > (position.y - (size.y * 0.3)) &&
          (intersectionPoints.first.x - intersectionPoints.last.x).abs() >
              size.x * 0.4) {
        if (blocksFallen > 3 && doFallDamage) {
          changeHealthBy(-(blocksFallen / 2));
        }

        isCollidingBottom = true;
        blocksFallen = 0;
        yVelocity = 0;
      }

      //Top collision
      if (individualIntersectionPoint.y < (position.y - (size.y * 0.75)) &&
          (intersectionPoints.first.x - intersectionPoints.last.x).abs() >
              size.x * 0.4 &&
          jumpForce > 0) {
        isCollidingTop = true;
      }

      //horizonatal collision
      if (individualIntersectionPoint.y < (position.y - (size.y * 0.3))) {
        //Right Collision
        if (individualIntersectionPoint.x > position.x) {
          isCollidingRight = true;

          //Left collision
        } else {
          isCollidingLeft = true;
        }
      }
    });
  }

  void jumpingLogic() {
    if (jumpForce > 0) {
      position.y -= jumpForce;
      jumpForce -= GameMethods.instance.blockSize.x * 0.15;
      if (isCollidingTop) {
        jumpForce = 0;
      }
    }
  }

  void fallingLogic(double dt) {
    if (!isCollidingBottom) {
      if (yVelocity < (GameMethods.instance.gravity * dt) * 10) {
        yVelocity += GameMethods.instance.gravity * dt;
      }
      position.y += yVelocity;
      blocksFallen += yVelocity / GameMethods.instance.blockSize.x;
    }
  }

  void setAllCollisionToFalse() {
    isCollidingBottom = false;
    isCollidingLeft = false;
    isCollidingRight = false;
    isCollidingTop = false;
  }

  bool move(
      ComponentMotionState componentMotionState, double dt, double speed) {
    switch (componentMotionState) {
      case ComponentMotionState.walkingLeft:
        if (!isCollidingLeft) {
          position.x -= speed;
          if (isFacingRight) {
            flipHorizontallyAroundCenter();
            isFacingRight = false;
          }

          return true;
        }

        return false;
      case ComponentMotionState.walkingRight:
        print("inside move $isCollidingRight");
        if (!isCollidingRight) {
          position.x += speed;
          if (!isFacingRight) {
            flipHorizontallyAroundCenter();
            isFacingRight = true;
          }
          return true;
        }

        return false;

      default:
        return false;
    }
  }

  void changeHealthBy(double value) {
    if (value < 0) {
      isHurt = true;
    }

    if (health + value <= 10) {
      if (health + value >= 0) {
        health += value;
      } else {
        health = 0;
      }
    } else {
      health = 10;
    }
  }

  void killEntityLogic() {
    if (health == 0) {
      removeFromParent();
    }
  }

  void jump() {
    if (isCollidingBottom) {
      jumpForce = GameMethods.instance.blockSize.x * 0.7;
    }
  }
}
