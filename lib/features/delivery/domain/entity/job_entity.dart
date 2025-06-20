import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String jobId;
  final String priority;
  final String startTime;
  final String endTime;
  final String recipient;
  final String imageUrl;

  const JobEntity({
    required this.jobId,
    required this.priority,
    required this.startTime,
    required this.endTime,
    required this.recipient,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [jobId, priority, startTime, endTime, recipient, imageUrl];
}