import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/items.dart';
import 'package:minecraft/utils/constants.dart';

part 'inventory.g.dart';

@HiveType(typeId: 2)
class InventoryManager {
  Rx<int> currentSelectedInventorySlot = 0.obs;

  Rx<bool> inventoryIsOpen = false.obs;

  late List<InventorySlot> inventorySlots = List.generate(
      36,
      (index) => InventorySlot(
          index: index, inventorySlotSave: inventorySlotsSave[index]));

  @HiveField(0)
  List<InventorySlotSave> inventorySlotsSave =
      List.generate(36, (index) => InventorySlotSave());

  //[purpleFlower, grass, , null]
  bool addBlockToInventory(dynamic block) {
    for (InventorySlot slot in inventorySlots) {
      //item
      if (slot.block == block) {
        //Item
        if (block is Items &&
            ItemData.getItemDataForItem(block).toolType == Tools.none) {
          if (slot.incrementCount()) {
            return true;
          }

          //block
        } else if (block is Blocks) {
          if ((slot.incrementCount())) {
            return true;
          }
        }

        //slot is empty
      } else if (slot.block == null) {
        slot.block = block;
        slot.count.value++;
        return true;
      }
    }

    return false;
  }
}

@HiveType(typeId: 3)
class InventorySlotSave {
  @HiveField(0)
  dynamic block;

  @HiveField(1)
  int count;

  InventorySlotSave({this.count = 0});
}

class InventorySlot {
  dynamic block;
  Rx<int> count = 0.obs;

  final int index;

  final InventorySlotSave inventorySlotSave;

  InventorySlot({required this.index, required this.inventorySlotSave}) {
    block = inventorySlotSave.block;
    count.value = inventorySlotSave.count;

    count.listen((value) {
      inventorySlotSave.count = value;
      inventorySlotSave.block = block;
    });
  }

  bool incrementCount() {
    if (count.value < stack) {
      count.value++;
      return true;
    }

    return false;
  }

  void decrementSlot() {
    count.value--;
    if (count.value == 0) {
      block = null;
    }
  }

  bool get isEmpty {
    if (count.value == 0) {
      return true;
    }

    return false;
  }

  void emptySlot() {
    count.value = 0;
    block = null;
  }
}
