import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/delivery/domain/entity/job_entity.dart';
import 'package:logitracker_mobile_app/features/delivery/domain/repository/job_repository.dart';

class GetUpcomingJobsUseCase {
  final JobRepository repository;

  GetUpcomingJobsUseCase(this.repository);

  Future<Either<Failure, List<JobEntity>>> call() async {
    return await repository.getUpcomingJobs();
  }
}
