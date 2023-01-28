// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NovelAdapter extends TypeAdapter<Novel> {
  @override
  final int typeId = 0;

  @override
  Novel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Novel(
      title: fields[0] as String,
      authors: (fields[6] as List).cast<String>(),
      description: fields[1] as String,
      coverUrl: fields[2] as String,
      sourceUrl: fields[3] as String,
      status: fields[4] as String,
      chapters: (fields[10] as List).cast<Chapter>(),
      sourceName: fields[5] as String,
      alternateTitles: (fields[7] as List?)?.cast<String>(),
      genres: (fields[8] as List?)?.cast<String>(),
      isFavorite: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Novel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.coverUrl)
      ..writeByte(3)
      ..write(obj.sourceUrl)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.sourceName)
      ..writeByte(6)
      ..write(obj.authors)
      ..writeByte(7)
      ..write(obj.alternateTitles)
      ..writeByte(8)
      ..write(obj.genres)
      ..writeByte(9)
      ..write(obj.isFavorite)
      ..writeByte(10)
      ..write(obj.chapters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
