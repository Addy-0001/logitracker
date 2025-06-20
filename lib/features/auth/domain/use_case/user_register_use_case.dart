import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class UserRegisterUseCase {
  final UserRepository repository;

  UserRegisterUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String company,
    required String phone,
    required String position,
    required String avatar,
    required String industry,
    required String size,
    required String website,
    required String address,
    required String preferences,
  }) {
    return repository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      company: company,
      phone: phone,
      position: position,
      avatar: avatar,
      industry: industry,
      size: size,
      website: website,
      address: address,
      preferences: preferences,
    );
  }
}
