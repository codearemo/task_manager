part of 'auth_module_bloc.dart';

sealed class AuthModuleEvent extends Equatable {
  const AuthModuleEvent();

  @override
  List<Object> get props => [];
}

final class SignInWithEmailEvent extends AuthModuleEvent {
  final AuthOpParams params;

  const SignInWithEmailEvent({
    required this.params,
  });
}

final class SignUpWithEmailEvent extends AuthModuleEvent {
  final AuthOpParams params;

  const SignUpWithEmailEvent({
    required this.params,
  });
}

final class GetCurrentUserEvent extends AuthModuleEvent {}

final class SignOutEvent extends AuthModuleEvent {}