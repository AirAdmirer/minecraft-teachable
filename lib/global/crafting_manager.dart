import 'package:get/get.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/inventory.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/items.dart';

class CraftingManager {
  Rx<bool> craftingInventoryIsOpen = false.obs;

  List<InventorySlot> playerInventoryCraftingGrid = List.generate(
      5,
      (index) =>
          InventorySlot(index: index, inventorySlotSave: InventorySlotSave()));

  List<InventorySlot> standardCraftingGrid = List.generate(
      10,
      (index) =>
          InventorySlot(index: index, inventorySlotSave: InventorySlotSave()));

  static bool isInPlayerInventory() {
    if (GlobalGameReference.instance.gameReference.worldData.inventoryManager
        .inventoryIsOpen.value) {
      return true;
    }
    return false;
  }

  bool checkForRecipe() {
    if (isInPlayerInventory()) {
      for (int index = 0;
          index < Recipe.playerInventoryGridRecipe.length;
          index++) {
        Recipe recipe = Recipe.playerInventoryGridRecipe[index];

        if (recipe.recipe.hasMatch(turnCraftingGridIntoAString(
            playerInventoryCraftingGrid, recipe.key))) {
          playerInventoryCraftingGrid.last.block = recipe.product;
          playerInventoryCraftingGrid.last.count.value = recipe.productCount;

          return true;
        }
      }
    } else {
      //
      for (int index = 0; index < Recipe.standardGridRecipe.length; index++) {
        Recipe recipe = Recipe.standardGridRecipe[index];
        if (recipe.recipe.hasMatch(
            turnCraftingGridIntoAString(standardCraftingGrid, recipe.key))) {
          standardCraftingGrid.last.block = recipe.product;
          standardCraftingGrid.last.count.value = recipe.productCount;

          return true;
        }
      }
    }

    standardCraftingGrid.last.emptySlot();
    playerInventoryCraftingGrid.last.emptySlot();

    return false;
  }

  void decrementOneFromEachSlot(List<InventorySlot> grid) {
    grid.asMap().forEach((int index, InventorySlot inventorySlot) {
      if (!inventorySlot.isEmpty) {
        inventorySlot.decrementSlot();
      }
    });
  }

  String turnCraftingGridIntoAString(
      List<InventorySlot> craftingGrid, Map key) {
    List gridString = [];

    craftingGrid.asMap().forEach((int index, InventorySlot inventorySlot) {
      if (inventorySlot.block == null) {
        gridString.add("E");
      } else if (key.containsKey(inventorySlot.block)) {
        gridString.add(key[inventorySlot.block]);
      }
    });

    return gridString.join();
  }
}

class Recipe {
  final RegExp recipe; //WEEW
  final dynamic product;
  final int productCount;
  final Map key; // {Blocks.birchPlanks : "W"}

  Recipe(
      {required this.recipe,
      required this.product,
      required this.productCount,
      required this.key});

  static List<Recipe> playerInventoryGridRecipe = [
    //dead bush stick
    Recipe(
        recipe: RegExp("^E*SE*\$"),
        key: {Blocks.deadBush: "S"},
        product: Items.stick,
        productCount: 1),

    //stick
    Recipe(
        recipe: RegExp("^E*WEWE*\$"),
        product: Items.stick,
        productCount: 4,
        key: {Blocks.birchPlank: "W"}),

    //birch planks
    Recipe(
        recipe: RegExp("^E*WE*\$"),
        key: {Blocks.birchLog: "W"},
        product: Blocks.birchPlank,
        productCount: 4),

    //crafting table
    Recipe(
        recipe: RegExp("^E*BBBBE*\$"),
        key: {Blocks.birchPlank: "B"},
        product: Blocks.craftingTable,
        productCount: 1),
  ];

  static List standardGridRecipe = [
    //dead bush stick
    Recipe(
        recipe: RegExp("^E*SE*\$"),
        key: {Blocks.deadBush: "S"},
        product: Items.stick,
        productCount: 1),

/*     //stick for standardGrid
    Recipe(
        recipe: RegExp("^E*WEEWE*\$"),
        key: {Blocks.birchPlank: "W"},
        product: Items.stick,
        productCount: 4), */

    //birch planks
    Recipe(
        recipe: RegExp("^E*WE*\$"),
        key: {Blocks.birchLog: "W"},
        product: Blocks.birchPlank,
        productCount: 4),

    //crafting table
    Recipe(
        recipe: RegExp("^E*BBEBBEE*\$"),
        key: {Blocks.birchPlank: "B"},
        product: Blocks.craftingTable,
        productCount: 1),

    //wooden sword
    Recipe(
        recipe: RegExp("^E*WEEWEESE*\$"),
        key: {Blocks.birchPlank: "W", Items.stick: "S"},
        product: Items.woodenSword,
        productCount: 1),

    //wooden shovel
    Recipe(
        recipe: RegExp("^E*WEESEESE*\$"),
        key: {Blocks.birchPlank: "W", Items.stick: "S"},
        product: Items.woodenShovel,
        productCount: 1),

    //wooden pickaxe
    Recipe(
        recipe: RegExp("WWWESEESE"),
        key: {Blocks.birchPlank: "W", Items.stick: "S"},
        product: Items.woodenPickaxe,
        productCount: 1),

    //wooden axe
    Recipe(
        recipe: RegExp("^E*WWESWESE*\$"),
        key: {Blocks.birchPlank: "W", Items.stick: "S"},
        product: Items.woodenAxe,
        productCount: 1),

    //Stone sword
    Recipe(
        recipe: RegExp("^E*CEECEESE*\$"),
        key: {Blocks.cobblestone: "C", Items.stick: "S"},
        product: Items.stoneSword,
        productCount: 1),

    //stone shovel
    Recipe(
        recipe: RegExp("^E*CEESEESE*\$"),
        key: {Blocks.cobblestone: "C", Items.stick: "S"},
        product: Items.stoneShovel,
        productCount: 1),

    //stone pickaxe
    Recipe(
        recipe: RegExp("CCCESEESE"),
        key: {Blocks.cobblestone: "C", Items.stick: "S"},
        product: Items.stonePickaxe,
        productCount: 1),

    //stone axe
    Recipe(
        recipe: RegExp("^E*CCESCESE*\$"),
        key: {Blocks.cobblestone: "C", Items.stick: "S"},
        product: Items.stoneAxe,
        productCount: 1),

    //iron sword
    Recipe(
        recipe: RegExp("^E*IEEIEESE*\$"),
        key: {Items.ironIngot: "I", Items.stick: "S"},
        product: Items.ironSword,
        productCount: 1),

    //iron shovel
    Recipe(
        recipe: RegExp("^E*IEESEESE*\$"),
        key: {Items.ironIngot: "I", Items.stick: "S"},
        product: Items.ironShovel,
        productCount: 1),

    //iron pickaxe
    Recipe(
        recipe: RegExp("IIIESEESE"),
        key: {Items.ironIngot: "I", Items.stick: "S"},
        product: Items.ironPickaxe,
        productCount: 1),

    //iron axe
    Recipe(
        recipe: RegExp("^E*IIESIESE*\$"),
        key: {Items.ironIngot: "I", Items.stick: "S"},
        product: Items.ironAxe,
        productCount: 1),

    //gold sword
    Recipe(
        recipe: RegExp("^E*GEEGEESE*\$"),
        key: {Items.goldIngot: "G", Items.stick: "S"},
        product: Items.goldenSword,
        productCount: 1),

    //gold shovel
    Recipe(
        recipe: RegExp("^E*GEESEESE*\$"),
        key: {Items.goldIngot: "G", Items.stick: "S"},
        product: Items.goldenShovel,
        productCount: 1),

    //gold pickaxe
    Recipe(
        recipe: RegExp("GGGESEESE"),
        key: {Items.goldIngot: "G", Items.stick: "S"},
        product: Items.goldenPickaxe,
        productCount: 1),

    //gold axe
    Recipe(
        recipe: RegExp("^E*GGESGESE*\$"),
        key: {Items.goldIngot: "G", Items.stick: "S"},
        product: Items.goldenAxe,
        productCount: 1),

    //diamond sword
    Recipe(
        recipe: RegExp("^E*DEEDEESE*\$"),
        key: {Items.diamond: "D", Items.stick: "S"},
        product: Items.diamondSword,
        productCount: 1),

    //diamond shovel
    Recipe(
        recipe: RegExp("^E*DEESEESE*\$"),
        key: {Items.diamond: "D", Items.stick: "S"},
        product: Items.diamondShovel,
        productCount: 1),

    //diamond pickaxe
    Recipe(
        recipe: RegExp("DDDESEESE"),
        key: {Items.diamondAxe: "D", Items.stick: "S"},
        product: Items.diamondPickaxe,
        productCount: 1),

    //diamond axe
    Recipe(
        recipe: RegExp("^E*DDESDESE*\$"),
        key: {Items.diamond: "D", Items.stick: "S"},
        product: Items.diamondAxe,
        productCount: 1),
  ];
}
