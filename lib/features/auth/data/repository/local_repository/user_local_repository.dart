import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:logitracker/features/auth/domain/repository/user_repository.dart';
import 'package:logitracker/core/error/failure.dart';
import 'package:logitracker/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:logitracker/features/auth/domain/entity/user_entity.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDatasource _userLocalDataSource;

  UserLocalRepository({
    required UserLocalDatasource userLocalDatasource,
  }) : _userLocalDataSource = userLocalDatasource;

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
    String username,
    String password,
  ) async {
    try {
      final result = await _userLocalDataSource.loginUser(
        username,
        password,
      );
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to login: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await _userLocalDataSource.registerUser(user);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to register: $e"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> loginStudent(String username, String password) {
    // TODO: implement loginStudent
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> registerStudent(UserEntity student) {
    // TODO: implement registerStudent
    throw UnimplementedError();
  }
}
