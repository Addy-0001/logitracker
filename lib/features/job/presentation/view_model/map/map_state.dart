part of 'map_view_model.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final CoordinateEntity coordinates;

  MapLoaded(this.coordinates);
}

class MapError extends MapState {
  final String message;

  MapError(this.message);
}

class MapLiveUpdateSuccess extends MapState {
  final CoordinateEntity updatedCoordinate;

  MapLiveUpdateSuccess(this.updatedCoordinate);
}
