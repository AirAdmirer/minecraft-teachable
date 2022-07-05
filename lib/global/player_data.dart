import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'player_data.g.dart';

@HiveType(typeId: 5)
class PlayerDataSave {
  @HiveField(0)
  double playerHunger = 10;

  @HiveField(1)
  double playerHealth = 10;

  @HiveField(2)
  bool playerIsDead = false;
}

class PlayerData {
  late Rx<double> playerHealth = playerDataSave.playerHealth.obs;
  late Rx<double> playerHunger = playerDataSave.playerHunger.obs;
  //hunger
  //staate- walkingLeft, walkingRight, idle
  ComponentMotionState componentMotionState = ComponentMotionState.idle;

  late Rx<bool> playerIsDead = playerDataSave.playerIsDead.obs;

  final PlayerDataSave playerDataSave;

  PlayerData({required this.playerDataSave}) {
    playerHealth.listen((value) {
      playerDataSave.playerHealth = value;
    });

    playerHunger.listen((value) {
      playerDataSave.playerHunger = value;
    });
  }
}

enum ComponentMotionState {
  walkingLeft,
  walkingRight,
  idle,
  jumping,
}
