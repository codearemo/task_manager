import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/exceptions.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/modules/task/data/datasource/remote/firebase/task_datasource.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/domain/repo/task_repo.dart';
import 'package:task_manager/modules/task/domain/usecases/add_task_usecase.dart';

class TaskRepoImpl implements TaskRepository {
  final FirebaseTaskDatasource remoteDataSource;

  TaskRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> addTask(TaskOpParams? params) async {
    try {
      return Right(await remoteDataSource.addTask(params));
    } on DatasourceException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String? taskId) async {
    try {
      return Right(await remoteDataSource.deleteTask(taskId));
    } on DatasourceException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Stream<List<TaskEnitity?>?>?>> getTasks() async {
    try {
      return Right(await remoteDataSource.getTasks());
    } on DatasourceException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskOpParams? params) async {
    try {
      return Right(await remoteDataSource.updateTask(params));
    } on DatasourceException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
