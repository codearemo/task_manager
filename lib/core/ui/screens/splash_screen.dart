import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/router/app_route_names.dart';
import 'package:task_manager/core/ui/widgets/feedback/app_loader.dart';
import 'package:task_manager/modules/auth/presentation/bloc/auth_module_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkAuthUser() async {
    final authModuleBloc = context.read<AuthModuleBloc>();

    authModuleBloc.add(GetCurrentUserEvent());
  }

  @override
  void initState() {
    super.initState();

    checkAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthModuleBloc, AuthModuleState>(
      listener: (context, state) {
        if (state is GetCurrentUserSuccess) {
          if (state.user == null) {
            context.go(AppRoutesNames.signin);
          } else {
            context.go(AppRoutesNames.allTasks);
          }
        } else if (state is GetCurrentUserError) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: AppLoader.circularLoader,
          ),
        );
      },
    );
  }
}
