import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/task/domain/repo/task_repo.dart';

class DeleteTaskUsecase implements GeneralUsecase<void, String?> {
  final TaskRepository repository;

  DeleteTaskUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(String? params) async {
    return await repository.deleteTask(params);
  }
}
