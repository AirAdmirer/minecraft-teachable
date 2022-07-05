// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlocksAdapter extends TypeAdapter<Blocks> {
  @override
  final int typeId = 1;

  @override
  Blocks read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Blocks.grass;
      case 1:
        return Blocks.dirt;
      case 2:
        return Blocks.stone;
      case 3:
        return Blocks.birchLog;
      case 4:
        return Blocks.birchLeaf;
      case 5:
        return Blocks.cactus;
      case 6:
        return Blocks.deadBush;
      case 7:
        return Blocks.sand;
      case 8:
        return Blocks.coalOre;
      case 9:
        return Blocks.ironOre;
      case 10:
        return Blocks.diamondOre;
      case 11:
        return Blocks.goldOre;
      case 12:
        return Blocks.grassPlant;
      case 13:
        return Blocks.redFlower;
      case 14:
        return Blocks.purpleFlower;
      case 15:
        return Blocks.drippingWhiteFlower;
      case 16:
        return Blocks.yellowFlower;
      case 17:
        return Blocks.whiteFlower;
      case 18:
        return Blocks.birchPlank;
      case 19:
        return Blocks.craftingTable;
      case 20:
        return Blocks.cobblestone;
      case 21:
        return Blocks.bedrock;
      default:
        return Blocks.grass;
    }
  }

  @override
  void write(BinaryWriter writer, Blocks obj) {
    switch (obj) {
      case Blocks.grass:
        writer.writeByte(0);
        break;
      case Blocks.dirt:
        writer.writeByte(1);
        break;
      case Blocks.stone:
        writer.writeByte(2);
        break;
      case Blocks.birchLog:
        writer.writeByte(3);
        break;
      case Blocks.birchLeaf:
        writer.writeByte(4);
        break;
      case Blocks.cactus:
        writer.writeByte(5);
        break;
      case Blocks.deadBush:
        writer.writeByte(6);
        break;
      case Blocks.sand:
        writer.writeByte(7);
        break;
      case Blocks.coalOre:
        writer.writeByte(8);
        break;
      case Blocks.ironOre:
        writer.writeByte(9);
        break;
      case Blocks.diamondOre:
        writer.writeByte(10);
        break;
      case Blocks.goldOre:
        writer.writeByte(11);
        break;
      case Blocks.grassPlant:
        writer.writeByte(12);
        break;
      case Blocks.redFlower:
        writer.writeByte(13);
        break;
      case Blocks.purpleFlower:
        writer.writeByte(14);
        break;
      case Blocks.drippingWhiteFlower:
        writer.writeByte(15);
        break;
      case Blocks.yellowFlower:
        writer.writeByte(16);
        break;
      case Blocks.whiteFlower:
        writer.writeByte(17);
        break;
      case Blocks.birchPlank:
        writer.writeByte(18);
        break;
      case Blocks.craftingTable:
        writer.writeByte(19);
        break;
      case Blocks.cobblestone:
        writer.writeByte(20);
        break;
      case Blocks.bedrock:
        writer.writeByte(21);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlocksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
