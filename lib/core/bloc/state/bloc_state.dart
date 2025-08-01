abstract class LoadingState {}

abstract class ErrorState {
  final String message;
  ErrorState(this.message);
}

abstract class LoadedState {}
