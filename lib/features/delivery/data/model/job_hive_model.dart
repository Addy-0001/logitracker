import 'package:hive/hive.dart';
import 'package:logitracker_mobile_app/features/delivery/domain/entity/job_entity.dart';
import 'package:logitracker_mobile_app/app/constant/hive_table_constant.dart';
part 'job_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.jobTypeId)
class JobHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? customerName;

  @HiveField(2)
  final String? status;

  JobHiveModel({required this.id, this.customerName, this.status});

  factory JobHiveModel.fromJson(Map<String, dynamic> json) {
    return JobHiveModel(
      id: json['_id'],
      customerName: json['customer']?['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'customer': {'name': customerName},
      'status': status,
    };
  }

  JobEntity toEntity() =>
      JobEntity(id: id, customerName: customerName, status: status);
}
