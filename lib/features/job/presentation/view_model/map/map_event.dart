part of 'map_view_model.dart';

abstract class MapEvent {}

class LoadAllCoordinates extends MapEvent {
  final String jobId;

  LoadAllCoordinates(this.jobId);
}

class UpdateLiveCoordinate extends MapEvent {
  final String jobId;
  final CoordinateEntity currentCoordinate;

  UpdateLiveCoordinate({
    required this.jobId,
    required this.currentCoordinate,
  });
}
