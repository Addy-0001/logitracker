import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/job_entity.dart';

abstract class JobRepository {
  Future<Either<Failure, JobEntity>> getOngoingJob();
  Future<Either<Failure, List<JobEntity>>> getUpcomingJobs();
}