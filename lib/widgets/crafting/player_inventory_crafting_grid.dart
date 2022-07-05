import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/utils/game_methods.dart';
import 'package:minecraft/widgets/inventory/inventory_slot.dart';

class PlayerInventoryCraftingGridWidget extends StatelessWidget {
  const PlayerInventoryCraftingGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: GameMethods.instance.slotSize / 3),
          child: SizedBox(
            height: GameMethods.instance.slotSize * 4,
            width: GameMethods.instance.slotSize * 9.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .playerInventoryCraftingGrid[0]),
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .playerInventoryCraftingGrid[1]),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .playerInventoryCraftingGrid[2]),
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .playerInventoryCraftingGrid[3]),
                      ],
                    )
                  ],
                ),
                SizedBox(
                    height: (GameMethods.instance.slotSize * 9.5) / 8,
                    child: Image.asset(
                        "assets/images/inventory/inventory_arrow.png")),
                InventorySlotWidget(
                    slotType: SlotType.craftingOutput,
                    inventorySlot: GlobalGameReference
                        .instance
                        .gameReference
                        .worldData
                        .craftingManager
                        .playerInventoryCraftingGrid[4])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
