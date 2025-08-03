part of 'job_detail_view_model.dart';

abstract class JobDetailState {}

class JobDetailInitial extends JobDetailState {}

class JobDetailLoading extends JobDetailState implements LoadingState {}

class JobDetailLoaded extends JobDetailState implements LoadedState {
  final JobEntity job;
  JobDetailLoaded(this.job);
}

class JobDetailError extends JobDetailState implements ErrorState {
  @override
  final String message;
  JobDetailError(this.message);
}
