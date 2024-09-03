import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/router/app_route_names.dart';
import 'package:task_manager/core/ui/widgets/app_confirm_content.dart';
import 'package:task_manager/modules/auth/presentation/bloc/auth_module_bloc.dart';
import 'package:task_manager/modules/task/presentation/screens/add_edit_task_screen.dart';
import 'package:task_manager/modules/task/presentation/widgets/tasks_list.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  triggerConfirmLogoutDialog() async {
    final authModuleBloc = context.read<AuthModuleBloc>();

    final confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmLogoutContentDialog();
      },
    );

    if (confirmLogout == true) {
      authModuleBloc.add(SignOutEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthModuleBloc, AuthModuleState>(
      listener: (authModuleBlocContext, authModuleState) {
        if (authModuleState is SignOutSuccess) {
          context.go(AppRoutesNames.signin);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Task Manager'),
            actions: [
              TextButton(
                onPressed: triggerConfirmLogoutDialog,
                child: const Text('Logout'),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed(
                AppRoutesNames.addEditTask,
                extra: AddEditPostScreenArgs(),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: const TasksList(),
        );
      },
    );
  }
}
