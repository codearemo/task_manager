import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/domain/usecases/add_task_usecase.dart';

abstract class TaskRepository {
  Future<Either<Failure, void>> addTask(TaskOpParams? params);
  Future<Either<Failure, void>> updateTask(TaskOpParams? params);
  Future<Either<Failure, void>> deleteTask(String? taskId);
  Future<Either<Failure, Stream<List<TaskEnitity?>?>?>> getTasks();
}
