import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/player_data.dart';
import 'package:minecraft/resources/sky_timer.dart';

class SkyComponent extends ParallaxComponent {
  ComponentMotionState componentMotionState = ComponentMotionState.walkingLeft;

  late ParallaxComponent morningSky;

  late ParallaxComponent eveningSky;

  late ParallaxComponent nightSky;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    morningSky =
        await GlobalGameReference.instance.gameReference.loadParallaxComponent([
      ParallaxImageData("parallax/morning/sky.png"),
      ParallaxImageData("parallax/morning/second_parallax.png"),
      ParallaxImageData("parallax/morning/first_parallax.png"),
    ], baseVelocity: Vector2(0, 0), velocityMultiplierDelta: Vector2(3, 0));

    eveningSky =
        await GlobalGameReference.instance.gameReference.loadParallaxComponent([
      ParallaxImageData("parallax/evening/sky.png"),
      ParallaxImageData("parallax/evening/second_parallax.png"),
      ParallaxImageData("parallax/evening/first_parallax.png"),
    ], baseVelocity: Vector2(0, 0), velocityMultiplierDelta: Vector2(3, 0));

    nightSky =
        await GlobalGameReference.instance.gameReference.loadParallaxComponent([
      ParallaxImageData("parallax/night/sky.png"),
      ParallaxImageData("parallax/night/second_parallax.png"),
      ParallaxImageData("parallax/night/first_parallax.png"),
    ], baseVelocity: Vector2(0, 0), velocityMultiplierDelta: Vector2(3, 0));

    switch (
        GlobalGameReference.instance.gameReference.worldData.skyTimer.skyTime) {
      case SkyTimerEnum.morning:
        parallax = morningSky.parallax;
        break;
      case SkyTimerEnum.evening:
        parallax = eveningSky.parallax;
        break;
      case SkyTimerEnum.night:
        parallax = nightSky.parallax;
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (componentMotionState == ComponentMotionState.idle) {
      parallax!.baseVelocity.x = 0;
    }
    if (componentMotionState == ComponentMotionState.walkingLeft) {
      parallax!.baseVelocity.x = 2;
    }
    if (componentMotionState == ComponentMotionState.walkingRight) {
      parallax!.baseVelocity.x = -2;
    }
  }
}
