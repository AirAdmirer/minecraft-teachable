import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:minecraft/utils/game_methods.dart';

class MinecraftButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const MinecraftButtonWidget(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = GameMethods.instance.getScreenSize();
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: screenSize.width * 0.4,
        height: 55,
        child: FittedBox(
          child: Stack(
            children: [
              Image.asset("assets/images/launcher/button_background.png"),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.grey[200],
                      fontFamily: "MinecraftFont",
                      shadows: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
