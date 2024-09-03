import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/domain/usecases/add_task_usecase.dart';

abstract class FirebaseTaskDatasource {
  Future<void> addTask(TaskOpParams? params);
  Future<void> updateTask(TaskOpParams? params);
  Future<void> deleteTask(String? taskId);
  Future<Stream<List<TaskEnitity?>?>?> getTasks();
}