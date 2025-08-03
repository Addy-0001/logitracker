import 'package:logitracker/features/job/data/data_source/remote_data_source/coordinate_remote_datasource.dart';
import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';

class CoordinateRemoteRepository implements ICoordinateRepository {
  final CoordinateRemoteDatasource _datasource;
  CoordinateRemoteRepository(this._datasource);

  @override
  Future<CoordinateEntity> getAllCoordinates(String jobId) async {
    var response = await _datasource.getAllCoordinates(jobId);
    return CoordinateEntity.fromMap(response);
  }

  @override
  Future<CoordinateEntity> getLiveCoordinate(String jobId) async {
    var response = await _datasource.getLiveCoordinate(jobId);
    return CoordinateEntity.fromMap(response);
  }

  @override
  Future<CoordinateEntity> getPickupDropoffCoordinates(String jobId) {
    var response = _datasource.getPickupAndDropoff(jobId);
    return response.then((data) => CoordinateEntity.fromMap(data));
  }

  @override
  Future<void> updateLiveCoordinate(String jobId, CoordinateEntity coordinate) {
    return _datasource.updateLiveCoordinate(
      jobId,
      coordinate.latitude,
      coordinate.longitude,
    );
  }
}
