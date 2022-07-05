import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:minecraft/global/world_data.dart';
import 'package:minecraft/screens/world_select_screen.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';
import 'package:minecraft/widgets/launcher/minecraft_button.dart';
import 'package:minecraft/widgets/launcher/minecraft_text_field.dart';

class CreateWorldScreen extends StatefulWidget {
  const CreateWorldScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorldScreen> createState() => _CreateWorldScreenState();
}

class _CreateWorldScreenState extends State<CreateWorldScreen> {
  TextEditingController worldNameController = TextEditingController();
  TextEditingController seedController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    worldNameController.dispose();
    seedController.dispose();
  }

  @override
  void initState() {
    super.initState();

    worldNameController.text = "New World";
    seedController.text = GameMethods.instance.getRandomSeed().toString();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = GameMethods.instance.getScreenSize();

    SizedBox space = const SizedBox(
      height: 20,
    );

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/launcher/dirt_background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Create New World",
              style: GameMethods.instance.minecraftTextStyle,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "World Name",
                  style: GameMethods.instance.minecraftTextStyle,
                ),
                space,
                MinecraftTextField(
                  textEditingController: worldNameController,
                  size: Size(
                    screenSize.width * 0.6,
                    55,
                  ),
                ),
                space,
                Text(
                  "Your world will be saved to this name",
                  style: GameMethods.instance.minecraftTextStyle.copyWith(
                      color: Colors.white.withOpacity(0.7), fontSize: 17),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Seed",
                  style: GameMethods.instance.minecraftTextStyle,
                ),
                space,
                MinecraftTextField(
                  textEditingController: seedController,
                  size: Size(
                    screenSize.width * 0.6,
                    55,
                  ),
                ),
                space,
                Text(
                  "This value will defines the terrain generation",
                  style: GameMethods.instance.minecraftTextStyle.copyWith(
                      color: Colors.white.withOpacity(0.7), fontSize: 17),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MinecraftButtonWidget(
                    text: "Back",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WorldSelectScreen()));
                    }),
                MinecraftButtonWidget(
                    text: "Create World",
                    onPressed: () {
                      int seed = int.parse(seedController.text);
                      Hive.box(worldDataBox).put(
                        seed,
                        WorldData(
                            seed: seed, worldName: worldNameController.text),
                      );

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WorldSelectScreen()));
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
