import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/auth/domain/repo/auth_repo.dart';
import 'package:task_manager/modules/auth/domain/usecases/signin_with_email_usecase.dart';

class SignUpWithEmailUsecase implements GeneralUsecase<User?, AuthOpParams> {
  final AuthRepo repository;

  SignUpWithEmailUsecase({
    required this.repository
    });

  @override
  Future<Either<Failure, User?>> call(AuthOpParams params) async {
    return await repository.signUpWithEmailAndPassword(params.email, params.password);
  }
}
