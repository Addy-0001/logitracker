import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/delivery/domain/entity/job_entity.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobEntity>>> getOngoingJobs();
  Future<Either<Failure, List<JobEntity>>> getUpcomingJobs();
}
