import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/auth/domain/repo/auth_repo.dart';

class SignOutUsecase implements GeneralUsecase<void, NoParams> {
  final AuthRepo repository;

  SignOutUsecase({
    required this.repository
    });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
