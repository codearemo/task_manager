import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/domain/usecases/add_task_usecase.dart';
import 'package:task_manager/modules/task/domain/usecases/delete_task_usecase.dart';
import 'package:task_manager/modules/task/domain/usecases/fetch_tasks_usecase.dart';
import 'package:task_manager/modules/task/domain/usecases/update_task_usecase.dart';

part 'task_module_event.dart';
part 'task_module_state.dart';

class TaskModuleBloc extends Bloc<TaskModuleEvent, TaskModuleState> {
  Stream<List<TaskEnitity?>?>? tasksStreamData;
  List<TaskEnitity?>? loadedTasks;

  final FetchTasksUsecase fetchTasksUsecase;
  final AddTaskUsecase addTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;

  TaskModuleBloc({
    required this.fetchTasksUsecase,
    required this.addTaskUsecase,
    required this.updateTaskUsecase,
    required this.deleteTaskUsecase,
  }) : super(TaskModuleInitial()) {
    on<TaskModuleEvent>(
      (event, emit) {},
    );
    on<AddTaskEvent>(_onAddTask);
    on<FetchTasksEvent>(_onFetchTasks);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  _onFetchTasks(FetchTasksEvent event, Emitter<TaskModuleState> emit) async {
    emit(FetchTasksLoading());

    final res = await fetchTasksUsecase(NoParams());

    res.fold(
      (failure) => emit(FetchTasksError(message: failure.message)),
      (tasks) {
        tasksStreamData = tasks;

        tasksStreamData?.asBroadcastStream().listen((tasks) {
          loadedTasks = tasks;
        });

        emit(FetchTasksSuccess(
          tasks: tasks,
        ));
      },
    );
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskModuleState> emit) async {
    emit(AddTaskLoading());

    final res = await addTaskUsecase(event.params);

    res.fold(
      (failure) => emit(AddTaskError(message: failure.message)),
      (task) => emit(const AddTaskSuccess()),
    );
  }

  void _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskModuleState> emit) async {
    emit(UpdateTaskLoading());
    final res = await updateTaskUsecase(event.params);

    res.fold(
      (failure) => emit(UpdateTaskError(message: failure.message)),
      (task) => emit(const UpdateTaskSuccess()),
    );
  }

  void _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskModuleState> emit) async {
    emit(DeleteTaskLoading());

    final res = await deleteTaskUsecase(event.taskId);

    res.fold(
      (failure) => emit(DeleteTaskError(message: failure.message)),
      (task) => emit(const DeleteTaskSuccess()),
    );
  }
}
