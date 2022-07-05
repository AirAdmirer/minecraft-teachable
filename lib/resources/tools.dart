import 'package:flame/components.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/world_data.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/items.dart';

List<Items> stoneTools = [
  Items.stoneAxe,
  Items.stonePickaxe,
  Items.stoneShovel,
];

List<Items> woodenTools = [
  Items.woodenAxe,
  Items.woodenPickaxe,
  Items.woodenShovel,
];

List<Items> ironTools = [
  Items.ironAxe,
  Items.ironPickaxe,
  Items.ironShovel,
];

List<Items> diamondTools = [
  Items.diamondAxe,
  Items.diamondPickaxe,
  Items.diamondShovel,
];

List<Items> goldTools = [
  Items.goldenAxe,
  Items.goldenPickaxe,
  Items.goldenShovel,
];

double getMiningSpeedChange(Blocks block) {
  WorldData worldData = GlobalGameReference.instance.gameReference.worldData;

  dynamic currentHeldItem = worldData
      .inventoryManager
      .inventorySlots[
          worldData.inventoryManager.currentSelectedInventorySlot.value]
      .block;

  //If what the player holding is a tool, and a suitable tool to be exact, pi
  if (currentHeldItem is Items &&
      ItemData.getItemDataForItem(currentHeldItem).toolType != Tools.none &&
      ItemData.getItemDataForItem(currentHeldItem).toolType ==
          BlockData.getBlockDataFor(block).suitableTool) {
    //wooden tier sitable tool
    if (woodenTools.contains(currentHeldItem)) {
      return 0.6;
    } else if (stoneTools.contains(currentHeldItem)) {
      return 0.5;
    } else if (ironTools.contains(currentHeldItem)) {
      return 0.4;
    } else if (diamondTools.contains(currentHeldItem)) {
      return 0.27;
    } else if (goldTools.contains(currentHeldItem)) {
      return 0.23;
    } else {
      return 1;
    }
  } else {
    return 1;
  }
}
