import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/error/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, User?>> signInWithEmailAndPassword(String email, String password);
  Future<Either<Failure, User?>> signUpWithEmailAndPassword(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User?>> getCurrentUser();
}