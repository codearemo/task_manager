import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/usecases/general_usecase.dart';
import 'package:task_manager/modules/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:task_manager/modules/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:task_manager/modules/auth/domain/usecases/signout_usecase.dart';
import 'package:task_manager/modules/auth/domain/usecases/signup_with_email_usecase.dart';

part 'auth_module_event.dart';
part 'auth_module_state.dart';

class AuthModuleBloc extends Bloc<AuthModuleEvent, AuthModuleState> {
  User? currentUser;

  final SignInWithEmailUsecase signInWithEmailUsecase;
  final SignUpWithEmailUsecase signUpWithEmailUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final SignOutUsecase signOutUsecase;

  AuthModuleBloc({
    required this.signInWithEmailUsecase,
    required this.signUpWithEmailUsecase,
    required this.getCurrentUserUsecase,
    required this.signOutUsecase,
  }) : super(AuthModuleInitial()) {
    on<AuthModuleEvent>((event, emit) {});
    on<SignInWithEmailEvent>(_onSignInWithEmailEvent);
    on<SignUpWithEmailEvent>(_onSignUpWithEmailEvent);
    on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }

  _onGetCurrentUserEvent(
      GetCurrentUserEvent event, Emitter<AuthModuleState> emit) async {
    emit(GetCurrentUserLoading());

    final failureOrUser = await getCurrentUserUsecase(NoParams());

    failureOrUser.fold(
      (failure) => emit(GetCurrentUserError(message: failure.message)),
      (user) {
        currentUser = user;
        emit(GetCurrentUserSuccess(user: user));
      },
    );
  }

  _onSignOutEvent(SignOutEvent event, Emitter<AuthModuleState> emit) async {
    emit(SignOutLoading());

    final failureOrUser = await signOutUsecase(NoParams());

    failureOrUser.fold(
      (failure) => emit(SignOutError(message: failure.message)),
      (user) => emit(SignOutSuccess()),
    );
  }

  _onSignUpWithEmailEvent(
      SignUpWithEmailEvent event, Emitter<AuthModuleState> emit) async {
    emit(SignUpWithEmailLoading());

    final failureOrUser = await signUpWithEmailUsecase(event.params);

    failureOrUser.fold(
      (failure) => emit(SignUpWithEmailError(message: failure.message)),
      (user) {
        currentUser = user;
        emit(SignUpWithEmailSuccess(user: user));
      },
    );
  }

  _onSignInWithEmailEvent(
      SignInWithEmailEvent event, Emitter<AuthModuleState> emit) async {
    emit(SignInWithEmailLoading());

    final failureOrUser = await signInWithEmailUsecase(event.params);
    failureOrUser.fold(
      (failure) => emit(SignInWithEmailError(message: failure.message)),
      (user) {
        currentUser = user;
        emit(SignInWithEmailSuccess(user: user));
      },
    );
  }
}
