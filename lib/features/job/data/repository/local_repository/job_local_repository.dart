import 'package:dartz/dartz.dart';
import 'package:logitracker/features/job/data/data_source/local_data_source/job_local_data_source.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/features/job/domain/repository/job_repository.dart';
import '../../../../../core/error/failure.dart';

class JobLocalRepository implements JobRepository {
  final JobLocalDataSource dataSource;

  JobLocalRepository(this.dataSource);

  @override
  Future<Either<Failure, JobEntity>> getOngoingJob() async {
    try {
      final job = JobEntity(
        jobId: '1',
        priority: "Medium Priority",
        startTime: "2 PM",
        endTime: "3 PM",
        recipient: "Adamya Neupane",
        imageUrl: "imageUrl",
      );
      await dataSource.saveJob(job);
      return Right(job);
    } catch (e) {
      return Left(Failure('Failed to get ongoing job'));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getUpcomingJobs() async {
    try {
      final jobs = [
        JobEntity(
          jobId: '2',
          priority: "High Priority",
          startTime: "3 PM",
          endTime: "4 PM",
          recipient: "John Doe",
          imageUrl: "imageUrl",
        ),
        JobEntity(
          jobId: '3',
          priority: "Low Priority",
          startTime: "4 PM",
          endTime: "4:30 PM",
          recipient: "Jane Doe",
          imageUrl: "imageUrl",
        ),
        JobEntity(
          jobId: '4',
          priority: "High Priority",
          startTime: "4 PM",
          endTime: "5 PM",
          recipient: "Random Name",
          imageUrl: "imageUrl",
        ),
        JobEntity(
          jobId: '5',
          priority: "Medium Priority",
          startTime: "6 PM",
          endTime: "7 PM",
          recipient: "User 1123",
          imageUrl: "imageUrl",
        ),
      ];
      for (var job in jobs) {
        await dataSource.saveJob(job);
      }
      return Right(jobs);
    } catch (e) {
      return Left(Failure('Failed to get upcoming jobs'));
    }
  }
}
