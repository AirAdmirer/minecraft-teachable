import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/player_data.dart';
import 'package:minecraft/widgets/controller_button_widget.dart';

class ControllerWidget extends StatelessWidget {
  const ControllerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerData playerData =
        GlobalGameReference.instance.gameReference.worldData.playerData;
    return Positioned(
      bottom: 100,
      left: 20,
      child: Row(
        children: [
          ControllerButtonWidget(
              path: "assets/controller/left_button.png",
              onPressed: () {
                playerData.componentMotionState =
                    ComponentMotionState.walkingLeft;
              }),
          ControllerButtonWidget(
              path: "assets/controller/center_button.png",
              onPressed: () {
                playerData.componentMotionState = ComponentMotionState.jumping;
              }),
          ControllerButtonWidget(
              path: "assets/controller/right_button.png",
              onPressed: () {
                playerData.componentMotionState =
                    ComponentMotionState.walkingRight;
              }),
        ],
      ),
    );
  }
}
