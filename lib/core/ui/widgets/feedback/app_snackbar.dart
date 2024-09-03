import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_parllete.dart';

class AppSnackBars {
  static void primarySnackbar({
    required BuildContext context,
    required String message,
    backgroundColor = AppPallete.gradient1,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          backgroundColor: backgroundColor,
        ),
      );
  }
}
