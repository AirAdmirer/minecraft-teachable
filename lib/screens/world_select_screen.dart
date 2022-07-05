import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:minecraft/global/world_data.dart';
import 'package:minecraft/screens/create_world_screen.dart';
import 'package:minecraft/screens/menu_screen.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';
import 'package:minecraft/widgets/launcher/minecraft_button.dart';
import 'package:minecraft/widgets/launcher/world_preview_widget.dart';

class WorldSelectScreen extends StatefulWidget {
  const WorldSelectScreen({Key? key}) : super(key: key);

  @override
  State<WorldSelectScreen> createState() => _WorldSelectScreenState();
}

class _WorldSelectScreenState extends State<WorldSelectScreen> {
  List<Widget> children = [];

  @override
  void initState() {
    super.initState();

    Hive.box(worldDataBox).toMap().forEach((seed, worldData) {
      if (worldData is WorldData) {
        children.add(
            WorldPreViewWidget(worldName: worldData.worldName, seed: seed));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = GameMethods.instance.getScreenSize();
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/launcher/dirt_background.png"),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Select World",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "MinecraftFont",
                  fontSize: 20,
                  shadows: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                width: screenSize.width,
                height: screenSize.height * 0.7,
                color: Colors.black.withOpacity(0.4),
                child: ListView(children: children)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MinecraftButtonWidget(
                    text: "Back",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MenuScreen()));
                    }),
                MinecraftButtonWidget(
                    text: "Create World",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateWorldScreen()));
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
