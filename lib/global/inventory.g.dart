// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryManagerAdapter extends TypeAdapter<InventoryManager> {
  @override
  final int typeId = 2;

  @override
  InventoryManager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryManager()
      ..inventorySlotsSave = (fields[0] as List).cast<InventorySlotSave>();
  }

  @override
  void write(BinaryWriter writer, InventoryManager obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.inventorySlotsSave);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InventorySlotSaveAdapter extends TypeAdapter<InventorySlotSave> {
  @override
  final int typeId = 3;

  @override
  InventorySlotSave read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventorySlotSave(
      count: fields[1] as int,
    )..block = fields[0] as dynamic;
  }

  @override
  void write(BinaryWriter writer, InventorySlotSave obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.block)
      ..writeByte(1)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventorySlotSaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
