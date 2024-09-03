import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/presentation/bloc/task_module_bloc.dart';
import 'package:task_manager/modules/task/presentation/widgets/task_detail.dart';

class TaskDetailScreenArgs {
  final TaskEnitity? task;
  const TaskDetailScreenArgs({
    required this.task,
  });
}

class TaskDetailScreen extends StatefulWidget {
  final TaskDetailScreenArgs args;

  const TaskDetailScreen({
    super.key,
    required this.args,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final taskModuleBloc = context.read<TaskModuleBloc>();

    return BlocConsumer<TaskModuleBloc, TaskModuleState>(
      listener: (context, state) {
        if (state is DeleteTaskSuccess) {
          context.pop();
        }
      },
      builder: (context, state) {
        final List<TaskEnitity?> tasks = taskModuleBloc.loadedTasks ?? [];
        TaskEnitity? task;

        for (var i = 0; i < tasks.length; i++) {
          if (tasks[i]?.id == widget.args.task?.id) {
            task = tasks[i];
          }
        }

        return task == null ? Container() : TaskDetail(task: task);
      },
    );
  }
}
