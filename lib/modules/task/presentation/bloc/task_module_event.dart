part of 'task_module_bloc.dart';

sealed class TaskModuleEvent extends Equatable {
  const TaskModuleEvent();

  @override
  List<Object> get props => [];
}

class FetchTasksEvent extends TaskModuleEvent {}

class AddTaskEvent extends TaskModuleEvent {
  final TaskOpParams params;

  const AddTaskEvent({
    required this.params,
  });
}

class UpdateTaskEvent extends TaskModuleEvent {
  final TaskOpParams params;

  const UpdateTaskEvent({
    required this.params,
  });
}

class DeleteTaskEvent extends TaskModuleEvent {
  final String? taskId;

  const DeleteTaskEvent({
    required this.taskId,
  });
}
