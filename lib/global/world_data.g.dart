// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorldDataAdapter extends TypeAdapter<WorldData> {
  @override
  final int typeId = 0;

  @override
  WorldData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorldData(
      seed: fields[0] as int,
      worldName: fields[6] as String,
    )
      ..playerDataSave = fields[4] as PlayerDataSave
      ..rightWorldChunks = (fields[1] as List)
          .map((dynamic e) => (e as List).cast<Blocks?>())
          .toList()
      ..leftWorldChunks = (fields[2] as List)
          .map((dynamic e) => (e as List).cast<Blocks?>())
          .toList()
      ..inventoryManager = fields[3] as InventoryManager
      ..skyTimer = fields[5] as SkyTimer;
  }

  @override
  void write(BinaryWriter writer, WorldData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.seed)
      ..writeByte(6)
      ..write(obj.worldName)
      ..writeByte(4)
      ..write(obj.playerDataSave)
      ..writeByte(1)
      ..write(obj.rightWorldChunks)
      ..writeByte(2)
      ..write(obj.leftWorldChunks)
      ..writeByte(3)
      ..write(obj.inventoryManager)
      ..writeByte(5)
      ..write(obj.skyTimer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorldDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
