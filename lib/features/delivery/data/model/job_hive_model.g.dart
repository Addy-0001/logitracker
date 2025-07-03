// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'job_hive_model.dart';

class JobHiveModelAdapter extends TypeAdapter<JobHiveModel> {
  @override
  final int typeId = HiveTableConstant.jobTypeId;

  @override
  JobHiveModel read(BinaryReader reader) {
    return JobHiveModel(
      id: reader.read(),
      customerName: reader.read(),
      status: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, JobHiveModel obj) {
    writer.write(obj.id);
    writer.write(obj.customerName);
    writer.write(obj.status);
  }
}
