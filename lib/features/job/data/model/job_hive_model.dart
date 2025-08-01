import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'job_hive_model.g.dart';

@HiveType(typeId: 1)
class JobHiveModel extends Equatable {
  @HiveField(0)
  final String jobId;
  @HiveField(1)
  final String priority;
  @HiveField(2)
  final String startTime;
  @HiveField(3)
  final String endTime;
  @HiveField(4)
  final String recipient;
  @HiveField(5)
  final String imageUrl;

  const JobHiveModel({
    required this.jobId,
    required this.priority,
    required this.startTime,
    required this.endTime,
    required this.recipient,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
    jobId,
    priority,
    startTime,
    endTime,
    recipient,
    imageUrl,
  ];
}
