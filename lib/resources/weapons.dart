import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/world_data.dart';
import 'package:minecraft/resources/items.dart';

List<Items> woodenTierWeapons = [
  Items.woodenSword,
  Items.stonePickaxe,
  Items.stoneShovel,
];

List<Items> stoneTierWeapons = [
  Items.stoneSword,
  Items.woodenAxe,
  Items.ironShovel,
  Items.ironPickaxe,
];

List<Items> ironTierWeapons = [
  Items.ironSword,
  Items.stoneAxe,
  Items.diamondShovel,
  Items.diamondPickaxe,
];

List<Items> diamondTierWeapons = [
  Items.diamondSword,
  Items.ironAxe,
  Items.goldenShovel,
  Items.goldenPickaxe,
];

List<Items> goldTierWeapons = [
  Items.goldenSword,
  Items.diamondAxe,
];

int getDamage() {
  WorldData worldData = GlobalGameReference.instance.gameReference.worldData;

  dynamic currentHeldItem = worldData
      .inventoryManager
      .inventorySlots[
          worldData.inventoryManager.currentSelectedInventorySlot.value]
      .block;

  //If what the player holding is a tool, and a suitable tool to be exact, pi
  if (currentHeldItem is Items) {
    //wooden tier sitable tool
    if (woodenTierWeapons.contains(currentHeldItem)) {
      return 2;
    } else if (stoneTierWeapons.contains(currentHeldItem)) {
      return 3;
    } else if (ironTierWeapons.contains(currentHeldItem)) {
      return 4;
    } else if (diamondTierWeapons.contains(currentHeldItem)) {
      return 5;
    } else if (goldTierWeapons.contains(currentHeldItem)) {
      return 6;
    } else {
      return 1;
    }
  } else {
    return 1;
  }
}
