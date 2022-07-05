import 'package:hive/hive.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/utils/constants.dart';

part 'sky_timer.g.dart';

@HiveType(typeId: 7)
enum SkyTimerEnum {
  @HiveField(0)
  morning,

  @HiveField(1)
  evening,

  @HiveField(2)
  night,
}

@HiveType(typeId: 6)
class SkyTimer {
  @HiveField(0)
  double skyTimerSeconds = 0;

  @HiveField(1)
  SkyTimerEnum skyTime = SkyTimerEnum.morning;

  void updateTimer(double dt) {
    skyTimerSeconds += dt;

    //every 1/3rd of the games total day time
    if (skyTimerSeconds >= totalTimeInADay / 3) {
      if (skyTime == SkyTimerEnum.morning) {
        skyTime = SkyTimerEnum.evening;

        GlobalGameReference.instance.gameReference.skyComponent.parallax =
            GlobalGameReference
                .instance.gameReference.skyComponent.eveningSky.parallax;
      } else if (skyTime == SkyTimerEnum.evening) {
        skyTime = SkyTimerEnum.night;
        GlobalGameReference.instance.gameReference.skyComponent.parallax =
            GlobalGameReference
                .instance.gameReference.skyComponent.nightSky.parallax;
      } else if (skyTime == SkyTimerEnum.night) {
        skyTime = SkyTimerEnum.morning;
        GlobalGameReference.instance.gameReference.skyComponent.parallax =
            GlobalGameReference
                .instance.gameReference.skyComponent.morningSky.parallax;
      }

      skyTimerSeconds = 0;
    }
  }
}
