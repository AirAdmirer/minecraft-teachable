import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/utils/game_methods.dart';

class InventorySlotBackgroundWidget extends StatelessWidget {
  final SlotType slotType;
  final int index;
  const InventorySlotBackgroundWidget(
      {Key? key, required this.slotType, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GameMethods.instance.slotSize,
      height: GameMethods.instance.slotSize,
      child: FittedBox(
          child: Obx(
        () => index ==
                    GlobalGameReference.instance.gameReference.worldData
                        .inventoryManager.currentSelectedInventorySlot.value &&
                slotType == SlotType.itemBar
            ? Image.asset("assets/images/inventory/inventory_active_slot.png")
            : Image.asset(
                getPath(),
              ),
      )),
    );
  }

  String getPath() {
    switch (slotType) {
      case SlotType.inventory:
        return "assets/images/inventory/inventory_item_storage_slot.png";
      case SlotType.itemBar:
        return "assets/images/inventory/inventory_item_bar_slot.png";
      case SlotType.crafting:
        return "assets/images/inventory/inventory_item_storage_slot.png";
      case SlotType.craftingOutput:
        return "assets/images/inventory/inventory_item_storage_slot.png";
    }
  }
}
