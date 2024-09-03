part of 'task_module_bloc.dart';

sealed class TaskModuleState extends Equatable {
  const TaskModuleState();

  @override
  List<Object> get props => [];
}

final class TaskModuleInitial extends TaskModuleState {}

final class AddTaskLoading extends TaskModuleState {}

final class FetchTasksLoading extends TaskModuleState {}

final class UpdateTaskLoading extends TaskModuleState {}

final class DeleteTaskLoading extends TaskModuleState {}

final class FetchTasksSuccess extends TaskModuleState {
  final Stream<List<TaskEnitity?>?>? tasks;

  const FetchTasksSuccess({
    required this.tasks,
  });
}

final class FetchTasksError extends TaskModuleState {
  final String message;

  const FetchTasksError({
    required this.message,
  });
}

final class AddTaskSuccess extends TaskModuleState {
  const AddTaskSuccess();
}

final class AddTaskError extends TaskModuleState {
  final String message;

  const AddTaskError({
    required this.message,
  });
}

final class UpdateTaskSuccess extends TaskModuleState {
  const UpdateTaskSuccess();
}

final class UpdateTaskError extends TaskModuleState {
  final String message;

  const UpdateTaskError({
    required this.message,
  });
}

final class DeleteTaskSuccess extends TaskModuleState {
  const DeleteTaskSuccess();
}

final class DeleteTaskError extends TaskModuleState {
  final String message;

  const DeleteTaskError({
    required this.message,
  });
}
