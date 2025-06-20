import 'package:dartz/dartz.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import '../../../../../core/error/failure.dart';
import '../../../../domain/repository/user_repository.dart';
import '../../data_source/local_datasource/user_local_data_source.dart';

class UserLocalRepository implements UserRepository {
  final UserLocalDataSource dataSource;

  UserLocalRepository(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = await dataSource.getUser(email);
    if (user != null && user.password == password) {
      return Right(user);
    }
    return Left(Failure('Invalid credentials'));
  }

  @override
  Future<Either<Failure, UserEntity>> register({
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
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = UserEntity(
      userId: DateTime.now().millisecondsSinceEpoch.toString(),
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
      role: "driver",
    );
    await dataSource.saveUser(user);
    return Right(user);
  }
}
