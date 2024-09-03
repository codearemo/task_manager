import 'package:get_it/get_it.dart';
import 'package:task_manager/core/resolvers/init_dependencies.dart';
import 'package:task_manager/modules/auth/data/datasource/remote/firebase/auth_firebase_datasource.dart';
import 'package:task_manager/modules/auth/data/datasource/remote/firebase/auth_firebase_datasource_impl.dart';
import 'package:task_manager/modules/auth/data/repo/auth_repo_impl.dart';
import 'package:task_manager/modules/auth/domain/repo/auth_repo.dart';
import 'package:task_manager/modules/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:task_manager/modules/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:task_manager/modules/auth/domain/usecases/signout_usecase.dart';
import 'package:task_manager/modules/auth/domain/usecases/signup_with_email_usecase.dart';
import 'package:task_manager/modules/auth/presentation/bloc/auth_module_bloc.dart';

GetIt getAuthModuleDependencies() {
  return serviceLocator
    ..registerFactory<FirebaseAuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSourceImpl(
        firebaseAuth: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepo>(
      () => AuthRepoImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignInWithEmailUsecase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetCurrentUserUsecase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignOutUsecase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignUpWithEmailUsecase(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthModuleBloc(
        signInWithEmailUsecase: serviceLocator(),
        getCurrentUserUsecase: serviceLocator(),
        signOutUsecase: serviceLocator(),
        signUpWithEmailUsecase: serviceLocator(),
      ),
    );
}