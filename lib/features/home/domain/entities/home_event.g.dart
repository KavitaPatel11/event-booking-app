// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeEventAdapter extends TypeAdapter<HomeEvent> {
  @override
  final int typeId = 1;

  @override
  HomeEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeEvent(
      id: fields[0] as int,
      title: fields[1] as String,
      date: fields[2] as String,
      location: fields[3] as String,
      price: fields[4] as double,
      thumbnail: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HomeEvent obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.thumbnail)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
