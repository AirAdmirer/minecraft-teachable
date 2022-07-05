import 'package:get/get.dart';
import 'package:minecraft/main_game.dart';

class GlobalGameReference {
  late MainGame gameReference;

  static GlobalGameReference get instance {
    return Get.put(GlobalGameReference());
  }
}
