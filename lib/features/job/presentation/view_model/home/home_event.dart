part of 'home_view_model.dart';

abstract class HomeEvent {}

class FetchJobs extends HomeEvent {
  final String? driverId;
  FetchJobs(this.driverId);
}
