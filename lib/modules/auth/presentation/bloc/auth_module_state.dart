part of 'auth_module_bloc.dart';

sealed class AuthModuleState extends Equatable {
  const AuthModuleState();

  @override
  List<Object> get props => [];
}

final class AuthModuleInitial extends AuthModuleState {}

final class SignInWithEmailLoading extends AuthModuleState {}

final class SignUpWithEmailLoading extends AuthModuleState {}

final class SignOutLoading extends AuthModuleState {}

final class GetCurrentUserLoading extends AuthModuleState {}

final class GetCurrentUserSuccess extends AuthModuleState {
  final User? user;

  const GetCurrentUserSuccess({
    required this.user,
  });
}

final class GetCurrentUserError extends AuthModuleState {
  final String message;

  const GetCurrentUserError({
    required this.message,
  });
}

final class SignOutSuccess extends AuthModuleState {}

final class SignOutError extends AuthModuleState {
  final String message;

  const SignOutError({
    required this.message,
  });
}

final class SignUpWithEmailSuccess extends AuthModuleState {
  final User? user;

  const SignUpWithEmailSuccess({
    required this.user,
  });
}

final class SignUpWithEmailError extends AuthModuleState {
  final String message;

  const SignUpWithEmailError({
    required this.message,
  });
}

final class SignInWithEmailSuccess extends AuthModuleState {
  final User? user;

  const SignInWithEmailSuccess({
    required this.user,
  });
}

final class SignInWithEmailError extends AuthModuleState {
  final String message;

  const SignInWithEmailError({
    required this.message,
  });
}
