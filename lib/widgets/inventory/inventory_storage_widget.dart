import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:minecraft/components/item_component.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/inventory.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';
import 'package:minecraft/widgets/inventory/inventory_slot.dart';

class InventoryStorageWidget extends StatelessWidget {
  const InventoryStorageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double inventoryStorageSize = GameMethods.instance.slotSize * 9.5;
    return Row(
      children: [
        //dragtarge here
        getDragTarget(Direction.left),

        Padding(
          padding: EdgeInsets.only(bottom: GameMethods.instance.slotSize / 1.5),
          child: SizedBox(
            height: GameMethods.instance.getScreenSize().height * 0.8,
            width: GameMethods.instance.getScreenSize().height * 0.8,
            child: FittedBox(
              child: Stack(
                children: [
                  //This is the background image
                  SizedBox(
                    width: inventoryStorageSize,
                    height: inventoryStorageSize,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                          "assets/images/inventory/inventory_background.png"),
                    ),
                  ),

                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            getRow(3),
                            getRow(2),
                            getRow(1),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GameMethods.instance.slotSize / 3),
                                child: getRow(0)),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),

        //dragtarge here
        getDragTarget(Direction.right)
      ],
    );
  }

  Widget getDragTarget(Direction direction) {
    return Expanded(
        child: InkWell(
      onTap: () {
        //if crafting inventory i sopen
        if (GlobalGameReference.instance.gameReference.worldData.craftingManager
            .craftingInventoryIsOpen.value) {
          GlobalGameReference.instance.gameReference.worldData.craftingManager
              .craftingInventoryIsOpen.value = false;
        }
      },
      child: SizedBox(
        height: GameMethods.instance.slotSize * 9.5,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) => Container(),
          onAccept: (InventorySlot inventorySlot) {
            for (int i = 0; i < inventorySlot.count.value; i++) {
              Vector2 spawningPosition;

              if (direction == Direction.right) {
                spawningPosition = Vector2(
                    GameMethods.instance.playerXIndexPosition + maxReach,
                    GameMethods.instance.playerYIndexPosition - maxReach);
              } else {
                spawningPosition = Vector2(
                    GameMethods.instance.playerXIndexPosition - maxReach,
                    GameMethods.instance.playerYIndexPosition - maxReach);
              }
              GlobalGameReference.instance.gameReference.worldData.items.add(
                  ItemComponent(
                      spawnBlockIndex: spawningPosition,
                      item: inventorySlot.block!));
            }

            inventorySlot.emptySlot();
          },
        ),
      ),
    ));
  }

  Widget getRow(int rowIndex) {
    int newRowIndex = rowIndex * 9; //0 : 0, 1 : 9, 2 : 18
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 0],
        ),
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 1],
        ),
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 2],
        ),
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 3],
        ),
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 4],
        ),
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 5],
        ),
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 6],
        ),
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 7],
        ),
        InventorySlotWidget(
          slotType: SlotType.inventory,
          inventorySlot: GlobalGameReference.instance.gameReference.worldData
              .inventoryManager.inventorySlots[newRowIndex + 8],
        ),
      ],
    );
  }
}
