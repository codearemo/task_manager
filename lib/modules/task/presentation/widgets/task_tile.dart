import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/router/app_route_names.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/presentation/screens/task_detail_screen.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final TaskEnitity? task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return ListTile(
      title: Row(
        children: [
          Text('${task?.title}'),
          const SizedBox(
            width: 5,
          ),
          Icon(
            task?.isCompleted == true
                ? Icons.check_circle
                : Icons.hourglass_bottom_rounded,
            color: task?.isCompleted == true ? Colors.green : Colors.orange,
            size: 10,
          )
        ],
      ),
      subtitle: Text(
        '${task?.description}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.pushNamed(
          AppRoutesNames.taskDetails,
          extra: TaskDetailScreenArgs(
            task: task,
          ),
        );
      },
    );
  }
}
