part of 'home_view_model.dart';

abstract class HomeEvent {}

class FetchJobs extends HomeEvent {
  final String? jobId;
  FetchJobs(this.jobId);
}
