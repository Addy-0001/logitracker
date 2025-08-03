import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';

abstract interface class ICoordinateRepository {
  Future<void> updateLiveCoordinate(String jobId, CoordinateEntity coordinate);
  Future<CoordinateEntity> getLiveCoordinate(String jobId);
  Future<JobCoordinates> getPickupDropoffCoordinates(String jobId);
  Future<JobCoordinates> getAllCoordinates(String jobId);
}
