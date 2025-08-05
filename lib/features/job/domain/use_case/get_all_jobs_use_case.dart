import 'package:dartz/dartz.dart';
import 'package:logitracker/core/utility/usecase.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/features/job/domain/repository/job_repository.dart';

class GetAllJobsUseCase implements UsecaseWithParams<List<JobEntity>, String?> {
  final IJobRepository _repository;
  GetAllJobsUseCase(this._repository);

  @override
  Future<Either<Exception, List<JobEntity>>> call(String? driverId) async {
    try {
      var data = await _repository.getAllJobs(driverId: driverId);
      return Right(data);
    } catch (e) {
      return Future.value(Left(Exception(e.toString())));
    }
  }
}
