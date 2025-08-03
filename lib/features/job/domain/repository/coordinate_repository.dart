import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';

abstract interface class ICoordinateRepository {
  Future<void> updateLiveCoordinate(String jobId, CoordinateEntity coordinate);
  Future<CoordinateEntity> getLiveCoordinate(String jobId);
  Future<CoordinateEntity> getPickupDropoffCoordinates(String jobId);
  Future<CoordinateEntity> getAllCoordinates(String jobId);
}
