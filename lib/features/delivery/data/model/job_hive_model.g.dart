// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobHiveModelAdapter extends TypeAdapter<JobHiveModel> {
  @override
  final int typeId = 1;

  @override
  JobHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobHiveModel(
      jobId: fields[0] as String,
      priority: fields[1] as String,
      startTime: fields[2] as String,
      endTime: fields[3] as String,
      recipient: fields[4] as String,
      imageUrl: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JobHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.jobId)
      ..writeByte(1)
      ..write(obj.priority)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.recipient)
      ..writeByte(5)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
