import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/router/app_route_names.dart';
import 'package:task_manager/core/theme/app_parllete.dart';
import 'package:task_manager/core/ui/widgets/feedback/app_loader.dart';
import 'package:task_manager/modules/auth/presentation/bloc/auth_module_bloc.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/presentation/bloc/task_module_bloc.dart';
import 'package:task_manager/modules/task/presentation/screens/add_edit_task_screen.dart';
import 'package:task_manager/modules/task/presentation/widgets/confirm_delete_task_content.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({
    super.key,
    required this.task,
  });

  final TaskEnitity? task;

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  void triggerDeleteProduct() {
    final taskModuleBloc = context.read<TaskModuleBloc>();

    taskModuleBloc.add(
      DeleteTaskEvent(
        taskId: widget.task?.id,
      ),
    );
  }

  void triggerConfirmDeleteDialog() async {
    final confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteContentDialog(
          task: widget.task,
        );
      },
    );

    if (confirmLogout == true) {
      triggerDeleteProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authModuleBloc = context.read<AuthModuleBloc>();

    return BlocSelector<TaskModuleBloc, TaskModuleState, TaskModuleState>(
      selector: (state) {
        return state;
      },
      builder: (context, state) {
        final task = widget.task;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Task Detail'),
            actions: [
              if (task?.authorId == authModuleBloc.currentUser?.uid) ...[
                state is DeleteTaskLoading
                    ? Container(
                        margin: const EdgeInsets.only(right: 16),
                        width: 20,
                        height: 20,
                        child: AppLoader.circularLoader,
                      )
                    : IconButton(
                        onPressed: triggerConfirmDeleteDialog,
                        icon: const Icon(Icons.delete),
                      ),
              ],
            ],
          ),
          floatingActionButton: task?.authorId == authModuleBloc.currentUser?.uid ? FloatingActionButton(
            onPressed: () {
              context.pushNamed<TaskEnitity?>(
                AppRoutesNames.addEditTask,
                extra: AddEditPostScreenArgs(
                  task: widget.task,
                ),
              );
            },
            child: const Icon(Icons.edit_note),
          ) : null,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        '${task?.title}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        task?.isCompleted == true
                            ? Icons.check_circle
                            : Icons.hourglass_bottom_rounded,
                        color: task?.isCompleted == true
                            ? Colors.green
                            : Colors.orange,
                        size: 20,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${task?.authorEmail}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppPallete.gradient1,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: (task?.selectedCateories ?? []).map((category) {
                      return Chip(
                        label: Text(category),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '${task?.description}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
