import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:logitracker_mobile_app/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:logitracker_mobile_app/features/auth/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String company,
    required String password,
    String? role,
  });
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> logout();
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, UserEntity>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String company,
    required String password,
    String? role,
  }) async {
    try {
      final userModel = await remoteDataSource.signup(
        firstName: firstName,
        lastName: lastName,
        email: email,
        company: company,
        password: password,
        role: role,
      );
      await localDataSource.saveUser(userModel);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      await localDataSource.saveUser(userModel);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final token = await localDataSource.getToken();
      if (token == null) return Left(ServerFailure('No token found'));
      final userModel = await remoteDataSource.getCurrentUser(token);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearUser();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure('Logout failed: $e'));
    }
  }
}
