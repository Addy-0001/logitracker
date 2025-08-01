import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/job_entity.dart';
import '../repository/job_repository.dart';

class GetUpcomingJobsUseCase {
  final JobRepository repository;

  GetUpcomingJobsUseCase(this.repository);

  Future<Either<Failure, List<JobEntity>>> call() {
    return repository.getUpcomingJobs();
  }
}
