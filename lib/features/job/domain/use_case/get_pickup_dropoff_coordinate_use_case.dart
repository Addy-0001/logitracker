import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';

class GetPickupDropoffCoordinatesUseCase {
  final ICoordinateRepository repository;

  GetPickupDropoffCoordinatesUseCase(this.repository);

  Future<JobCoordinates> call(String jobId) {
    return repository.getPickupDropoffCoordinates(jobId);
  }
}
