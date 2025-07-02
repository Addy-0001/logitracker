import 'package:dartz/dartz.dart';
import 'package:logitracker/core/error/failure.dart';
import 'package:logitracker/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:logitracker/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import 'package:logitracker/features/auth/domain/repository/user_repository.dart';

class UserLocalRepository implements UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource?
  remoteDataSource; // Nullable to handle potential null

  UserLocalRepository(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      if (remoteDataSource == null) {
        throw Failure('Remote data source is not initialized');
      }
      final user = await remoteDataSource!.login(email, password);
      await localDataSource.saveUser(user); // Cache user locally
      return Right(user);
    } catch (e) {
      final localUser = await localDataSource.getUser(email);
      if (localUser != null && localUser.password == password) {
        return Right(localUser); // Fallback to local cache
      }
      return Left(Failure('Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? company,
    String? phone,
    String? position,
    String? avatar,
    String? industry,
    String? size,
    String? website,
    String? address,
    String? preferences,
    String? role,
  }) async {
    try {
      if (remoteDataSource == null) {
        throw Failure('Remote data source is not initialized');
      }
      final user = await remoteDataSource!.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      await localDataSource.saveUser(user); // Cache user locally
      return Right(user);
    } catch (e) {
      return Left(Failure('Registration failed: ${e.toString()}'));
    }
  }
}
