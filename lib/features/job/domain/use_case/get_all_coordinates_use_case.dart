import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';

class GetAllCoordinatesUseCase {
  final ICoordinateRepository repository;

  GetAllCoordinatesUseCase(this.repository);

  Future<CoordinateEntity> call(String jobId) {
    return repository.getAllCoordinates(jobId);
  }
}
