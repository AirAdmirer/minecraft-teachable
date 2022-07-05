// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemsAdapter extends TypeAdapter<Items> {
  @override
  final int typeId = 4;

  @override
  Items read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Items.woodenSword;
      case 1:
        return Items.woodenShovel;
      case 2:
        return Items.woodenPickaxe;
      case 3:
        return Items.woodenAxe;
      case 4:
        return Items.stoneSword;
      case 5:
        return Items.stoneShovel;
      case 6:
        return Items.stonePickaxe;
      case 7:
        return Items.stoneAxe;
      case 8:
        return Items.ironSword;
      case 9:
        return Items.ironShovel;
      case 10:
        return Items.ironPickaxe;
      case 11:
        return Items.ironAxe;
      case 12:
        return Items.diamondSword;
      case 13:
        return Items.diamondShovel;
      case 14:
        return Items.diamondPickaxe;
      case 15:
        return Items.diamondAxe;
      case 16:
        return Items.goldenSword;
      case 17:
        return Items.goldenShovel;
      case 18:
        return Items.goldenPickaxe;
      case 19:
        return Items.goldenAxe;
      case 20:
        return Items.coal;
      case 21:
        return Items.ironIngot;
      case 22:
        return Items.diamond;
      case 23:
        return Items.apple;
      case 24:
        return Items.stick;
      case 25:
        return Items.goldIngot;
      default:
        return Items.woodenSword;
    }
  }

  @override
  void write(BinaryWriter writer, Items obj) {
    switch (obj) {
      case Items.woodenSword:
        writer.writeByte(0);
        break;
      case Items.woodenShovel:
        writer.writeByte(1);
        break;
      case Items.woodenPickaxe:
        writer.writeByte(2);
        break;
      case Items.woodenAxe:
        writer.writeByte(3);
        break;
      case Items.stoneSword:
        writer.writeByte(4);
        break;
      case Items.stoneShovel:
        writer.writeByte(5);
        break;
      case Items.stonePickaxe:
        writer.writeByte(6);
        break;
      case Items.stoneAxe:
        writer.writeByte(7);
        break;
      case Items.ironSword:
        writer.writeByte(8);
        break;
      case Items.ironShovel:
        writer.writeByte(9);
        break;
      case Items.ironPickaxe:
        writer.writeByte(10);
        break;
      case Items.ironAxe:
        writer.writeByte(11);
        break;
      case Items.diamondSword:
        writer.writeByte(12);
        break;
      case Items.diamondShovel:
        writer.writeByte(13);
        break;
      case Items.diamondPickaxe:
        writer.writeByte(14);
        break;
      case Items.diamondAxe:
        writer.writeByte(15);
        break;
      case Items.goldenSword:
        writer.writeByte(16);
        break;
      case Items.goldenShovel:
        writer.writeByte(17);
        break;
      case Items.goldenPickaxe:
        writer.writeByte(18);
        break;
      case Items.goldenAxe:
        writer.writeByte(19);
        break;
      case Items.coal:
        writer.writeByte(20);
        break;
      case Items.ironIngot:
        writer.writeByte(21);
        break;
      case Items.diamond:
        writer.writeByte(22);
        break;
      case Items.apple:
        writer.writeByte(23);
        break;
      case Items.stick:
        writer.writeByte(24);
        break;
      case Items.goldIngot:
        writer.writeByte(25);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
