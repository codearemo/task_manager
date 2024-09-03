import 'package:flutter/material.dart';

class ConfirmLogoutContentDialog extends StatelessWidget {
  const ConfirmLogoutContentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Logout?',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        'Are you sure you want to logout?',
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
          child: const Text('Logout',
              style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}