// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterAdapter extends TypeAdapter<Chapter> {
  @override
  final int typeId = 1;

  @override
  Chapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chapter(
      title: fields[0] as String,
      sourceUrl: fields[1] as String,
      index: fields[2] as int,
      isRead: fields[3] as bool,
      isBookmarked: fields[4] as bool,
      isDownloaded: fields[5] as bool,
    )..content = fields[6] as dynamic;
  }

  @override
  void write(BinaryWriter writer, Chapter obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.sourceUrl)
      ..writeByte(2)
      ..write(obj.index)
      ..writeByte(3)
      ..write(obj.isRead)
      ..writeByte(4)
      ..write(obj.isBookmarked)
      ..writeByte(5)
      ..write(obj.isDownloaded)
      ..writeByte(6)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
