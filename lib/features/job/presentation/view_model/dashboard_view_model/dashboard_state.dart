import 'package:logitracker/features/job/domain/entity/job_entity.dart';

class DashboardState {
  final bool isLoading;
  final String? errorMessage;
  final JobEntity? ongoingJob;
  final List<JobEntity> upcomingJobs;

  DashboardState({
    this.isLoading = false,
    this.errorMessage,
    this.ongoingJob,
    this.upcomingJobs = const [],
  });

  DashboardState copyWith({
    bool? isLoading,
    String? errorMessage,
    JobEntity? ongoingJob,
    List<JobEntity>? upcomingJobs,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      ongoingJob: ongoingJob ?? this.ongoingJob,
      upcomingJobs: upcomingJobs ?? this.upcomingJobs,
    );
  }
}
