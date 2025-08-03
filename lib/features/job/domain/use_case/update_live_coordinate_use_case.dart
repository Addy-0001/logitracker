import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';

class UpdateLiveCoordinateUseCase {
  final ICoordinateRepository repository;

  UpdateLiveCoordinateUseCase(this.repository);

  Future<void> call(String jobId, CoordinateEntity coordinate) {
    return repository.updateLiveCoordinate(jobId, coordinate);
  }
}
