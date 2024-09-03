import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/resolvers/init_dependencies.dart';
import 'package:task_manager/core/router/app_router.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/modules/auth/presentation/bloc/auth_module_bloc.dart';
import 'package:task_manager/modules/task/presentation/bloc/task_module_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthModuleBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<TaskModuleBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Task Manager',
      theme: AppTheme.darkTheme,
      routerDelegate: appRoutes.routerDelegate,
      routeInformationParser: appRoutes.routeInformationParser,
      routeInformationProvider: appRoutes.routeInformationProvider,
    );
  }
}
