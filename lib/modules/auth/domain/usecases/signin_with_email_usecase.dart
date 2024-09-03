import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/auth/domain/repo/auth_repo.dart';

class SignInWithEmailUsecase implements GeneralUsecase<User?, AuthOpParams> {
  final AuthRepo repository;

  SignInWithEmailUsecase({
    required this.repository
    });

  @override
  Future<Either<Failure, User?>> call(AuthOpParams params) async {
    return await repository.signInWithEmailAndPassword(params.email, params.password);
  }
}

class AuthOpParams {
  final String email;
  final String password;

  AuthOpParams({required this.email, required this.password});
}
