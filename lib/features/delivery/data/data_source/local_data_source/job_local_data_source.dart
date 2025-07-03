import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/delivery/data/model/job_hive_model.dart';
import 'package:logitracker_mobile_app/app/constant/hive_table_constant.dart';

class JobLocalDataSource {
  Future<Either<Failure, List<JobHiveModel>>> getJobs() async {
    try {
      final box = await Hive.openBox(HiveTableConstant.jobBox);
      final jobs = box.values
          .map(
            (e) => JobHiveModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
      return Right(jobs);
    } catch (e) {
      return Left(CacheFailure('Failed to retrieve jobs: $e'));
    }
  }

  Future<Either<Failure, void>> saveJob(JobHiveModel job) async {
    try {
      final box = await Hive.openBox(HiveTableConstant.jobBox);
      await box.put(job.id, job.toJson());
      return Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to save job: $e'));
    }
  }
}
