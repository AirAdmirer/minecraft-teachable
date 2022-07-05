import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:minecraft/widgets/player_health_bar.dart';
import 'package:minecraft/widgets/player_hunger_bar.dart';

class HungerAndHealthBar extends StatelessWidget {
  const HungerAndHealthBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [PlayerHealthBarWidget(), PlayerHungerBarWidget()],
      ),
    );
  }
}
