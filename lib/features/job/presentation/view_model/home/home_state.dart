part of 'home_view_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState implements LoadingState {}

class HomeLoaded extends HomeState implements LoadedState {
  final List<JobEntity> jobs;
  HomeLoaded(this.jobs);
}

class HomeError extends HomeState implements ErrorState {
  @override
  final String message;
  HomeError(this.message);
}
