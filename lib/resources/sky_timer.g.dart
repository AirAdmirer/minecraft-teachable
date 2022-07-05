// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sky_timer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SkyTimerAdapter extends TypeAdapter<SkyTimer> {
  @override
  final int typeId = 6;

  @override
  SkyTimer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SkyTimer()
      ..skyTimerSeconds = fields[0] as double
      ..skyTime = fields[1] as SkyTimerEnum;
  }

  @override
  void write(BinaryWriter writer, SkyTimer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.skyTimerSeconds)
      ..writeByte(1)
      ..write(obj.skyTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkyTimerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SkyTimerEnumAdapter extends TypeAdapter<SkyTimerEnum> {
  @override
  final int typeId = 7;

  @override
  SkyTimerEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SkyTimerEnum.morning;
      case 1:
        return SkyTimerEnum.evening;
      case 2:
        return SkyTimerEnum.night;
      default:
        return SkyTimerEnum.morning;
    }
  }

  @override
  void write(BinaryWriter writer, SkyTimerEnum obj) {
    switch (obj) {
      case SkyTimerEnum.morning:
        writer.writeByte(0);
        break;
      case SkyTimerEnum.evening:
        writer.writeByte(1);
        break;
      case SkyTimerEnum.night:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkyTimerEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
