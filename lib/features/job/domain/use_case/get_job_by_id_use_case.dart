import 'package:dartz/dartz.dart';
import 'package:logitracker/core/utility/usecase.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/features/job/domain/repository/job_repository.dart';

class GetJobByIdUseCase
    implements UsecaseWithParams<SingleJobResponse, String> {
  final IJobRepository _repository;

  GetJobByIdUseCase(this._repository);

  @override
  Future<Either<Exception, SingleJobResponse>> call(String params) async {
    try {
      var data = await _repository.getJobById(params);
      return Right(data);
    } catch (e) {
      return Future.value(Left(Exception(e.toString())));
    }
  }
}
