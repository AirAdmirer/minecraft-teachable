import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/player_data.dart';
import 'package:minecraft/utils/game_methods.dart';

class ControllerButtonWidget extends StatefulWidget {
  final String path;
  final VoidCallback onPressed;
  const ControllerButtonWidget(
      {Key? key, required this.path, required this.onPressed})
      : super(key: key);

  @override
  State<ControllerButtonWidget> createState() => _ControllerButtonWidgetState();
}

class _ControllerButtonWidgetState extends State<ControllerButtonWidget> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed = true;
            widget.onPressed();
          });
        },
        onTapUp: (_) {
          setState(() {
            isPressed = false;
            GlobalGameReference.instance.gameReference.worldData.playerData
                .componentMotionState = ComponentMotionState.idle;
          });
        },
        child: Opacity(
          opacity: isPressed ? 0.5 : 0.8,
          child: SizedBox(
            height: screenSize.width / 17,
            width: screenSize.width / 17,
            child: Image.asset(widget.path),
          ),
        ),
      ),
    );
  }
}
