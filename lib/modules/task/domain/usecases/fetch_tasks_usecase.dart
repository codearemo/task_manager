import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/domain/repo/task_repo.dart';

class FetchTasksUsecase implements GeneralUsecase<Stream<List<TaskEnitity?>?>?, NoParams> {
  final TaskRepository repository;

  FetchTasksUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Stream<List<TaskEnitity?>?>?>> call(NoParams params) async {
    return await repository.getTasks();
  }
}
