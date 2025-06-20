import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repository/user_repository.dart';

class UserImageUploadUseCase {
  final UserRepository repository;

  UserImageUploadUseCase(this.repository);

  Future<Either<Failure, String>> call(String imagePath) async {
    return Left(Failure('Not implemented')); // Placeholder
  }
}
