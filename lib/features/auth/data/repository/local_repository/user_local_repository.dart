import 'package:dartz/dartz.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:logitracker_mobile_app/features/auth/data/model/user_hive_model.dart';

class UserLocalRepository {
  final UserLocalDataSource localDataSource;

  UserLocalRepository(this.localDataSource);

  Future<Either<Failure, UserHiveModel>> getUser() async {
    try {
      final user = await localDataSource.getUser();
      if (user == null) return Left(CacheFailure('No user found'));
      return Right(user);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> saveUser(UserHiveModel user) async {
    try {
      await localDataSource.saveUser(user);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = await localDataSource.getToken();
      if (token == null) return Left(CacheFailure('No token found'));
      return Right(token);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> clearUser() async {
    try {
      await localDataSource.clearUser();
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
