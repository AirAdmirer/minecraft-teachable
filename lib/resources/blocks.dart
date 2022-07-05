import 'package:flame/components.dart';
import 'package:hive/hive.dart';
import 'package:minecraft/blocks/birch_leaf_block.dart';
import 'package:minecraft/blocks/coal_ore_block.dart';
import 'package:minecraft/blocks/crafting_table_block.dart';
import 'package:minecraft/blocks/diamond_ore_block.dart';
import 'package:minecraft/blocks/gold_ore_block.dart';
import 'package:minecraft/blocks/iron_ore_block.dart';
import 'package:minecraft/blocks/sand_block.dart';
import 'package:minecraft/blocks/stone_block.dart';
import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/resources/items.dart';

part 'blocks.g.dart';

@HiveType(typeId: 1)
enum Blocks {
  @HiveField(0)
  grass,

  @HiveField(1)
  dirt,

  @HiveField(2)
  stone,

  @HiveField(3)
  birchLog,

  @HiveField(4)
  birchLeaf,

  @HiveField(5)
  cactus,

  @HiveField(6)
  deadBush,

  @HiveField(7)
  sand,

  @HiveField(8)
  coalOre,

  @HiveField(9)
  ironOre,

  @HiveField(10)
  diamondOre,

  @HiveField(11)
  goldOre,
  @HiveField(12)
  grassPlant,
  @HiveField(13)
  redFlower,
  @HiveField(14)
  purpleFlower,
  @HiveField(15)
  drippingWhiteFlower,

  @HiveField(16)
  yellowFlower,

  @HiveField(17)
  whiteFlower,

  @HiveField(18)
  birchPlank,

  @HiveField(19)
  craftingTable,

  @HiveField(20)
  cobblestone,

  @HiveField(21)
  bedrock,
}

class BlockData {
  final bool isCollidable;

  //seconds
  final double baseMiningSpeed;
  final bool breakable;

  final Tools suitableTool;

  BlockData(
      {required this.isCollidable,
      required this.baseMiningSpeed,
      required this.suitableTool,
      this.breakable = true});

  factory BlockData.getBlockDataFor(Blocks block) {
    switch (block) {
      case Blocks.dirt:
        return BlockData.soil;

      case Blocks.grass:
        return BlockData.soil;

      case Blocks.birchLeaf:
        return BlockData.leaf;

      case Blocks.birchLog:
        return BlockData.wood;

      case Blocks.cactus:
        return BlockData.plant;

      case Blocks.coalOre:
        return BlockData.stone;

      case Blocks.deadBush:
        return BlockData.plant;

      case Blocks.ironOre:
        return BlockData.stone;

      case Blocks.sand:
        return BlockData.soil;

      case Blocks.stone:
        return BlockData.stone;

      case Blocks.grassPlant:
        return BlockData.plant;

      case Blocks.redFlower:
        return BlockData.plant;

      case Blocks.purpleFlower:
        return BlockData.plant;

      case Blocks.drippingWhiteFlower:
        return BlockData.plant;

      case Blocks.yellowFlower:
        return BlockData.plant;

      case Blocks.whiteFlower:
        return BlockData.plant;

      case Blocks.diamondOre:
        return BlockData.stone;

      case Blocks.goldOre:
        return BlockData.stone;

      case Blocks.birchPlank:
        return BlockData.woodPlank;

      case Blocks.craftingTable:
        return BlockData.woodPlank;

      case Blocks.cobblestone:
        return BlockData.stone;

      case Blocks.bedrock:
        return BlockData.unbreakable;
    }
  }

  static BlockComponent getParentForBlock(
      Blocks block, Vector2 blockIndex, int chunkIndex) {
    switch (block) {
      case Blocks.craftingTable:
        return CraftingTableBlock(
            chunkIndex: chunkIndex, blockIndex: blockIndex);

      case Blocks.birchLeaf:
        return BirchLeafBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.stone:
        return StoneBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.coalOre:
        return CoalOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.ironOre:
        return IronOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.diamondOre:
        return DiamondOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.goldOre:
        return GoldOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.sand:
        return SandBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      default:
        return BlockComponent(
            block: block, blockIndex: blockIndex, chunkIndex: chunkIndex);
    }
  }

  static BlockData plant = BlockData(
      isCollidable: false,
      baseMiningSpeed: 0.0000001,
      suitableTool: Tools.none);

  static BlockData soil = BlockData(
      isCollidable: true, baseMiningSpeed: 0.75, suitableTool: Tools.shovel);

  static BlockData wood = BlockData(
      isCollidable: false, baseMiningSpeed: 3, suitableTool: Tools.axe);

  static BlockData leaf = BlockData(
      isCollidable: false, baseMiningSpeed: 0.35, suitableTool: Tools.axe);

  static BlockData stone = BlockData(
      isCollidable: true, baseMiningSpeed: 3.5, suitableTool: Tools.pickaxe);

  static BlockData woodPlank = BlockData(
      isCollidable: true, baseMiningSpeed: 2.5, suitableTool: Tools.axe);

  static BlockData unbreakable = BlockData(
      breakable: false,
      baseMiningSpeed: 1,
      isCollidable: true,
      suitableTool: Tools.none);
}
