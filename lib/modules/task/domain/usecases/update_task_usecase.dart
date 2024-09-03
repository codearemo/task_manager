import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/task/domain/repo/task_repo.dart';
import 'package:task_manager/modules/task/domain/usecases/add_task_usecase.dart';

class UpdateTaskUsecase implements GeneralUsecase<void, TaskOpParams?> {
  final TaskRepository repository;

  UpdateTaskUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(TaskOpParams? params) async {
    return await repository.updateTask(params);
  }
}
