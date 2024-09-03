import 'package:get_it/get_it.dart';
import 'package:task_manager/core/resolvers/init_dependencies.dart';
import 'package:task_manager/modules/task/data/datasource/remote/firebase/task_datasource.dart';
import 'package:task_manager/modules/task/data/datasource/remote/firebase/task_datasource_impl.dart';
import 'package:task_manager/modules/task/data/repo/task_repo_impl.dart';
import 'package:task_manager/modules/task/domain/repo/task_repo.dart';
import 'package:task_manager/modules/task/domain/usecases/add_task_usecase.dart';
import 'package:task_manager/modules/task/domain/usecases/delete_task_usecase.dart';
import 'package:task_manager/modules/task/domain/usecases/fetch_tasks_usecase.dart';
import 'package:task_manager/modules/task/domain/usecases/update_task_usecase.dart';
import 'package:task_manager/modules/task/presentation/bloc/task_module_bloc.dart';

GetIt getTaskModuleDependencies() {
  return serviceLocator
    ..registerFactory<FirebaseTaskDatasource>(
      () => FirebaseTaskDatasourceImpl(
        firestore: serviceLocator(),
      ),
    )
    ..registerFactory<TaskRepository>(
      () => TaskRepoImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => AddTaskUsecase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => DeleteTaskUsecase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FetchTasksUsecase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateTaskUsecase(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => TaskModuleBloc(
        addTaskUsecase: serviceLocator(),
        deleteTaskUsecase: serviceLocator(),
        fetchTasksUsecase: serviceLocator(),
        updateTaskUsecase: serviceLocator(),
      ),
    );
}