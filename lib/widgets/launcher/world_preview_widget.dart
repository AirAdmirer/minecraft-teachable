import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:minecraft/layout/game_layout.dart';
import 'package:minecraft/utils/game_methods.dart';

class WorldPreViewWidget extends StatelessWidget {
  final String worldName;
  final int seed;
  const WorldPreViewWidget(
      {Key? key, required this.worldName, required this.seed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = GameMethods.instance.getScreenSize();

    double height = screenSize.height / 7;
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GameLayout(seed: seed),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(child: Container()),
            SizedBox(
                width: screenSize.width * 0.6,
                height: height,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                          "assets/images/launcher/new_world_icon.jpg"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          worldName,
                          style: GameMethods.instance.minecraftTextStyle
                              .copyWith(color: Colors.grey[400]),
                        ),
                        Text(
                          "Seed: $seed",
                          style: GameMethods.instance.minecraftTextStyle
                              .copyWith(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    )
                  ],
                )),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
