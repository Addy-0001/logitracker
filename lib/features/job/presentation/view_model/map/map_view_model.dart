import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapViewModel extends Bloc<MapEvent, MapState> {
  final ICoordinateRepository _repository;

  MapViewModel(this._repository) : super(MapInitial()) {
    on<LoadAllCoordinates>(_onLoadAllCoordinates);
    on<UpdateLiveCoordinate>(_onUpdateLiveCoordinate);
  }

  Future<void> _onLoadAllCoordinates(
    LoadAllCoordinates event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    try {
      final data = await _repository.getAllCoordinates(event.jobId);
      emit(MapLoaded(data));
    } catch (e) {
      emit(MapError(e.toString()));
    }
  }

  Future<void> _onUpdateLiveCoordinate(
    UpdateLiveCoordinate event,
    Emitter<MapState> emit,
  ) async {
    try {
      await _repository.updateLiveCoordinate(
        event.jobId,
        event.currentCoordinate,
      );
      emit(MapLiveUpdateSuccess(event.currentCoordinate));
    } catch (e) {
      emit(MapError(e.toString()));
    }
  }
}
