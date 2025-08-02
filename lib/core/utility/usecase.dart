import 'package:dartz/dartz.dart';

abstract interface class UsecaseWithParams<SuccessType, Params> {
  Future<Either<Exception, SuccessType>> call(Params params);
}

abstract interface class UsecaseWithoutParams<SuccessType> {
  Future<Either<Exception, SuccessType>> call();
}
