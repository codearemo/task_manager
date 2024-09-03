import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/auth/domain/repo/auth_repo.dart';

class GetCurrentUserUsecase implements GeneralUsecase<User?, NoParams> {
  final AuthRepo repository;

  GetCurrentUserUsecase({required this.repository});

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
