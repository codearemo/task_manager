import 'package:flutter/material.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';

class ConfirmDeleteContentDialog extends StatelessWidget {
  const ConfirmDeleteContentDialog({
    super.key,
    required this.task,
  });

  final TaskEnitity? task;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete Task?',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        'Are you sure want to delete ${task?.title}?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
