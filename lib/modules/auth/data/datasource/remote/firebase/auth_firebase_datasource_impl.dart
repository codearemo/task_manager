// lib/features/auth/data/datasources/firebase_auth_remote_data_source.dart

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/error/exceptions.dart';
import 'package:task_manager/modules/auth/data/datasource/remote/firebase/auth_firebase_datasource.dart';

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  FirebaseAuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return firebaseAuth.currentUser;
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }
}
