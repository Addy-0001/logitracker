import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';

class UserImageUploadUseCase {
  // Implement if needed for avatar upload
  Future<Either<Failure, String>> call(String filePath) async {
    return Left(ServerFailure('Not implemented'));
  }
}
