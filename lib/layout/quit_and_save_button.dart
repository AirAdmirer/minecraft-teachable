import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/screens/menu_screen.dart';
import 'package:minecraft/utils/constants.dart';

class QuitAndSaveButton extends StatelessWidget {
  const QuitAndSaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {
              //saving world
              Hive.box(worldDataBox).put(
                  GlobalGameReference.instance.gameReference.worldData.seed,
                  GlobalGameReference.instance.gameReference.worldData);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MenuScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.grey[800]!,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
