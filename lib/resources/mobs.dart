import 'dart:math';

import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/mobs/spider.dart';
import 'package:minecraft/mobs/zombie.dart';
import 'package:minecraft/resources/hostile_entity.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';

class Mobs {
  int totalMobs = 0;

  void spawnHostileMobs() {
    if (totalMobs < mobCap) {
      GlobalGameReference.instance.gameReference.add(returnRandomHostileMob());
    } else {
      print("mobCap full");
    }
  }

  HostileEntity returnRandomHostileMob() {
    int mobNumber = Random().nextInt(2);

    switch (mobNumber) {
      case 0:
        return Zombie(
            spawnIndexPosition: GameMethods.instance.getSpawnPositionForMob());

      case 1:
        return Spider(
            spawnIndexPosition: GameMethods.instance.getSpawnPositionForMob());

      default:
        return Zombie(
            spawnIndexPosition: GameMethods.instance.getSpawnPositionForMob());
    }
  }
}
