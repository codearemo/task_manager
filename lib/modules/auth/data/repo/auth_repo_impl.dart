import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/error/exceptions.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/modules/auth/data/datasource/remote/firebase/auth_firebase_datasource.dart';
import 'package:task_manager/modules/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  AuthRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User?>> signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmailAndPassword(email, password);
      return Right(user);
    } on DatasourceException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } on DatasourceException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final user = await remoteDataSource.signOut();
      return Right(user);
    } on DatasourceException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final user = await remoteDataSource.signUpWithEmailAndPassword(email, password);
      return Right(user);
    } on DatasourceException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
