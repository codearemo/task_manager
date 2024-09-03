import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/core/resolvers/auth_module_dependencies.dart';
import 'package:task_manager/core/resolvers/task_module_dependencies.dart';
import 'package:task_manager/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuthFeatures();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  serviceLocator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}

_initAuthFeatures() {
  getAuthModuleDependencies();
  getTaskModuleDependencies();
}
