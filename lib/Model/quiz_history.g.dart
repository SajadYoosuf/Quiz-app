// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizHistoryAdapter extends TypeAdapter<QuizHistory> {
  @override
  final int typeId = 0;

  @override
  QuizHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizHistory(
      cateogryHistory: fields[3] as String?,
      date: fields[0] as String?,
      scoreHistory: fields[2] as int?,
      timeHistory: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, QuizHistory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.timeHistory)
      ..writeByte(2)
      ..write(obj.scoreHistory)
      ..writeByte(3)
      ..write(obj.cateogryHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
