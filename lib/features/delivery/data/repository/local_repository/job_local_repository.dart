import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/delivery/data/data_source/local_data_source/job_local_data_source.dart';
import 'package:logitracker_mobile_app/features/delivery/data/model/job_hive_model.dart';

class JobLocalRepository {
  final JobLocalDataSource localDataSource;

  JobLocalRepository(this.localDataSource);

  Future<Either<Failure, List<JobHiveModel>>> getJobs() async {
    try {
      return await localDataSource.getJobs();
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> saveJob(JobHiveModel job) async {
    try {
      return await localDataSource.saveJob(job);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
