import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/utils/game_methods.dart';

class PlayerHungerBarWidget extends StatelessWidget {
  const PlayerHungerBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Widget> children = [];

      double health = GlobalGameReference
          .instance.gameReference.worldData.playerData.playerHunger.value;

      for (int i = 10; i > 0; i--) {
        //i=10, health 3
        bool isFullHeart = false;

        if (health >= i) {
          isFullHeart = true;
        }

        children.add(getHeartWidget(isFullHeart));
      }

      return Row(children: children);
    });
  }

  Widget getHeartWidget(bool fullHeart) {
    double width = GameMethods.instance.getScreenSize().width / 30;
    return SizedBox(
      width: width,
      height: width,
      child: FittedBox(
        child: Stack(
          children: [
            //background
            Image.asset("assets/images/gui/empty_hunger.png"),

            fullHeart
                ? Image.asset("assets/images/gui/full_hunger.png")
                : Container(),
          ],
        ),
      ),
    );
  }
}
