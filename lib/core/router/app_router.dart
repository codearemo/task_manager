import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/router/app_route_names.dart';
import 'package:task_manager/core/ui/screens/splash_screen.dart';
import 'package:task_manager/modules/auth/presentation/ui/screens/signin_screen.dart';
import 'package:task_manager/modules/auth/presentation/ui/screens/signup_screen.dart';
import 'package:task_manager/modules/task/presentation/screens/add_edit_task_screen.dart';
import 'package:task_manager/modules/task/presentation/screens/all_tasks_screen.dart';
import 'package:task_manager/modules/task/presentation/screens/task_detail_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRoutes = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRoutesNames.initialScreen,
  routes: [
    GoRoute(
      path: AppRoutesNames.initialScreen,
      name: AppRoutesNames.initialScreen,
      builder: (context, state) => SplashScreen(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: AppRoutesNames.signin,
      name: AppRoutesNames.signin,
      builder: (context, state) => SigninScreen(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: AppRoutesNames.signup,
      name: AppRoutesNames.signup,
      builder: (context, state) => SignupScreen(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: AppRoutesNames.allTasks,
      name: AppRoutesNames.allTasks,
      builder: (context, state) => AllTasksScreen(
        key: state.pageKey,
      ),
      routes: [
        GoRoute(
          path: AppRoutesNames.taskDetails,
          name: AppRoutesNames.taskDetails,
          builder: (context, state) => TaskDetailScreen(
            key: state.pageKey,
            args: state.extra as TaskDetailScreenArgs,
          ),
        ),
        GoRoute(
          path: AppRoutesNames.addEditTask,
          name: AppRoutesNames.addEditTask,
          builder: (context, state) => AddEditPostScreen(
            key: state.pageKey,
            args: state.extra as AddEditPostScreenArgs,
          ),
        ),
      ],
    ),
  ],
);
