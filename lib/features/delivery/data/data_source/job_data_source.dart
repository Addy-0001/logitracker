import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/delivery/data/model/job_hive_model.dart';

abstract class JobDataSource {
  Future<Either<Failure, List<JobHiveModel>>> getJobs();
  Future<Either<Failure, JobHiveModel>> getJobById(String id);
}
