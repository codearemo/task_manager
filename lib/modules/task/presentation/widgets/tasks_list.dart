import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/ui/widgets/feedback/app_loader.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/presentation/bloc/task_module_bloc.dart';
import 'package:task_manager/modules/task/presentation/widgets/task_tile.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
  });

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late Stream<List<TaskEnitity?>?>? streamData;

  fetchTasks() {
    final tasksModuleBloc = context.read<TaskModuleBloc>();
    tasksModuleBloc.add(FetchTasksEvent());
  }

  @override
  void initState() {
    super.initState();

    fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskModuleBloc = context.watch<TaskModuleBloc>();

    return BlocConsumer<TaskModuleBloc, TaskModuleState>(
      listener: (context, state) {},
      builder: (context, state) {
        return StreamBuilder<List<TaskEnitity?>?>(
            stream: taskModuleBloc.tasksStreamData,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: AppLoader.circularLoader,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                final tasks = snapshot.data;

                return (tasks ?? []).isEmpty
                    ? const Center(
                        child: Text('No tasks found'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: tasks?.length,
                        itemBuilder: (context, index) {
                          final task = tasks?[index];
                          return TaskTile(
                            task: task,
                          );
                        },
                      );
              } else {
                return const Center(
                  child: Text(
                    'Unexpected Error Occurred.\nPlease contect support',
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }));
      },
    );
  }
}
