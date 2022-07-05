import 'package:hive/hive.dart';

part 'items.g.dart';

enum Tools { none, sword, shovel, pickaxe, axe }

@HiveType(typeId: 4)
enum Items {
  @HiveField(0)
  woodenSword,
  @HiveField(1)
  woodenShovel,
  @HiveField(2)
  woodenPickaxe,
  @HiveField(3)
  woodenAxe,
  @HiveField(4)
  stoneSword,
  @HiveField(5)
  stoneShovel,
  @HiveField(6)
  stonePickaxe,
  @HiveField(7)
  stoneAxe,
  @HiveField(8)
  ironSword,
  @HiveField(9)
  ironShovel,
  @HiveField(10)
  ironPickaxe,
  @HiveField(11)
  ironAxe,
  @HiveField(12)
  diamondSword,
  @HiveField(13)
  diamondShovel,
  @HiveField(14)
  diamondPickaxe,
  @HiveField(15)
  diamondAxe,
  @HiveField(16)
  goldenSword,
  @HiveField(17)
  goldenShovel,
  @HiveField(18)
  goldenPickaxe,
  @HiveField(19)
  goldenAxe,
  @HiveField(20)
  coal,
  @HiveField(21)
  ironIngot,
  @HiveField(22)
  diamond,
  @HiveField(23)
  apple,
  @HiveField(24)
  stick,
  @HiveField(25)
  goldIngot,
}

class ItemData {
  final Tools toolType;
  final bool isEatable;

  ItemData({this.toolType = Tools.none, this.isEatable = false});

  factory ItemData.getItemDataForItem(Items item) {
    switch (item) {
      case Items.stoneSword:
        return ItemData(toolType: Tools.sword);

      case Items.diamondAxe:
        return ItemData(toolType: Tools.axe);

      case Items.diamondShovel:
        return ItemData(toolType: Tools.axe);

      case Items.diamondPickaxe:
        return ItemData(toolType: Tools.pickaxe);

      case Items.diamondSword:
        return ItemData(toolType: Tools.sword);

      case Items.goldenAxe:
        return ItemData(toolType: Tools.axe);

      case Items.goldenPickaxe:
        return ItemData(toolType: Tools.pickaxe);

      case Items.goldenShovel:
        return ItemData(toolType: Tools.shovel);

      case Items.goldenSword:
        return ItemData(toolType: Tools.sword);

      case Items.ironPickaxe:
        return ItemData(toolType: Tools.pickaxe);

      case Items.ironShovel:
        return ItemData(toolType: Tools.shovel);

      case Items.ironSword:
        return ItemData(toolType: Tools.sword);

      case Items.stoneAxe:
        return ItemData(toolType: Tools.axe);

      case Items.stonePickaxe:
        return ItemData(toolType: Tools.pickaxe);

      case Items.stoneShovel:
        return ItemData(toolType: Tools.shovel);

      case Items.woodenAxe:
        return ItemData(toolType: Tools.axe);

      case Items.woodenPickaxe:
        return ItemData(toolType: Tools.pickaxe);

      case Items.woodenShovel:
        return ItemData(toolType: Tools.shovel);

      case Items.woodenSword:
        return ItemData(toolType: Tools.sword);

      case Items.ironAxe:
        return ItemData(toolType: Tools.sword);

      case Items.apple:
        return ItemData(isEatable: true);

      default:
        return ItemData();
    }
  }
}
