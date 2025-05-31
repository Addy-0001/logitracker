class JobModel {
  final String priority;
  final String startTime;
  final String endTime;
  final String recipient;
  final String imageUrl;

  const JobModel({
    required this.priority,
    required this.startTime,
    required this.endTime,
    required this.recipient,
    required this.imageUrl,
  });
}
