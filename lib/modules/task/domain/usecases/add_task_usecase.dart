import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/domain/repo/task_repo.dart';

class AddTaskUsecase implements GeneralUsecase<void, TaskOpParams?> {
  final TaskRepository repository;

  AddTaskUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(TaskOpParams? params) async {
    return await repository.addTask(params);
  }
}

class TaskOpParams {
  final TaskEnitity? task;

  TaskOpParams({
    required this.task,
  });
}
