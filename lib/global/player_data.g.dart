// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerDataSaveAdapter extends TypeAdapter<PlayerDataSave> {
  @override
  final int typeId = 5;

  @override
  PlayerDataSave read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerDataSave()
      ..playerHunger = fields[0] as double
      ..playerHealth = fields[1] as double
      ..playerIsDead = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, PlayerDataSave obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.playerHunger)
      ..writeByte(1)
      ..write(obj.playerHealth)
      ..writeByte(2)
      ..write(obj.playerIsDead);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerDataSaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
