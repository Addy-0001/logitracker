import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/job_entity.dart';
import '../repository/job_repository.dart';

class GetOngoingJobUseCase {
  final JobRepository repository;

  GetOngoingJobUseCase(this.repository);

  Future<Either<Failure, JobEntity>> call() {
    return repository.getOngoingJob();
  }
}
