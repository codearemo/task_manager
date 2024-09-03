import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();
}

