import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';

abstract interface class GeneralUsecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
  // Stream<Either<Failure, T>> callStream(Params params);
}

// For usecase that need no params
class NoParams {}