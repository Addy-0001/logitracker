import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';

class GetLiveCoordinateUseCase {
  final ICoordinateRepository repository;

  GetLiveCoordinateUseCase(this.repository);

  Future<CoordinateEntity> call(String jobId) {
    return repository.getLiveCoordinate(jobId);
  }
}
