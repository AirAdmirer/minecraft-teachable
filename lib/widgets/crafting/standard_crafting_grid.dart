import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/utils/game_methods.dart';
import 'package:minecraft/widgets/inventory/inventory_slot.dart';

class StandardCraftingGrid extends StatelessWidget {
  const StandardCraftingGrid({Key? key}) : super(key: key);

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
                                .standardCraftingGrid[0]),
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .standardCraftingGrid[1]),
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .standardCraftingGrid[2]),
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
                                .standardCraftingGrid[3]),
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .standardCraftingGrid[4]),
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .standardCraftingGrid[5]),
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
                                .standardCraftingGrid[6]),
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .standardCraftingGrid[7]),
                        InventorySlotWidget(
                            slotType: SlotType.crafting,
                            inventorySlot: GlobalGameReference
                                .instance
                                .gameReference
                                .worldData
                                .craftingManager
                                .standardCraftingGrid[8]),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    height: (GameMethods.instance.slotSize * 9.5) / 8,
                    child: Image.asset(
                        "assets/images/inventory/inventory_arrow.png")),

                //output
                InventorySlotWidget(
                    slotType: SlotType.craftingOutput,
                    inventorySlot: GlobalGameReference.instance.gameReference
                        .worldData.craftingManager.standardCraftingGrid[9])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
