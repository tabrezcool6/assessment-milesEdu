import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_sign_out_usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_session_usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_sign_in_usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_sign_up_usecase.dart';
import 'package:assessment_miles_edu/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_reset_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Bloc for managing authentication-related events and states.
/// Handles sign-up, sign-in, reset password, sign-out, and session management.
///
/// This Bloc coordinates the UI and domain layers, emitting states in response to authentication events.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthSignUpWithEmail _authSignUpWithEmail;
  final AuthSignInWithEmail _authSignInWithEmail;
  final AuthResetPassword _authResetPassword;
  final AuthSignOut _authSignOut;
  final AuthSession _authSession;
  final AppUserCubit _appUserCubit;

  /// Constructor to inject dependencies for authentication use cases and app user management.
  AuthBloc({
    required AuthSignUpWithEmail authSignUpWithEmail,
    required AuthSignInWithEmail authSignInWithEmail,
    required AuthResetPassword authResetPassword,
    required AuthSignOut authSignOut,
    required AuthSession authSession,
    required AppUserCubit appUserCubit,
  }) : _authSignUpWithEmail = authSignUpWithEmail,
       _authSignInWithEmail = authSignInWithEmail,
       _authResetPassword = authResetPassword,
       _authSignOut = authSignOut,
       _authSession = authSession,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    // Register event handlers for all authentication events.
    // Emit loading state for any generic AuthEvent (can be used for debugging or global loading).
    on<AuthEvent>((_, emit) => emit(AuthLoading()));

    // Handle user sign-up with email event.
    on<AuthSignUpWithEmailEvent>(_onAuthSignUpWithEmail);

    // Handle user sign-in with email event.
    on<AuthSignInWithEmailEvent>(_onAuthSignInWithEmail);

    // Handle password reset event.
    on<AuthForgotPassword>(_onAuthResetPassword);

    // Handle user sign-out event.
    on<AuthSignOutEvent>(_onAuthSignOut);

    // Handle session check event.
    on<AuthCheckSessionEvent>(_onAuthCheckSessionEvent);
  }

  /// Handles the sign-up event.
  /// Calls the sign-up use case and emits either [AuthFailure] or [AuthSignInSuccess].
  Future<void> _onAuthSignUpWithEmail(
    AuthSignUpWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _authSignUpWithEmail(
      AuthSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),

      // (currentUser) => _emitAuthSuccess(null, emit),
      (_) => emit(AuthSignInSuccess(uid: '')),
    );
  }

  /// Handles the sign-in event.
  /// Calls the sign-in use case and emits either [AuthFailure] or [AuthSignInSuccess].
  Future<void> _onAuthSignInWithEmail(
    AuthSignInWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _authSignInWithEmail(
      AuthSignInParams(email: event.email, password: event.password),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      // (currentUser) => _emitAuthSuccess(null, emit),
      (_) => emit(AuthSignInSuccess(uid: '')),

      // (_) => emit(AuthSignInSuccess()),
    );
  }

  /// Handles the reset password event.
  /// Calls the reset password use case and emits either [AuthFailure] or [AuthResetPasswordSuccess].
  Future<void> _onAuthResetPassword(
    AuthForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await _authResetPassword(
      ResetPasswordParams(email: event.email),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthResetPasswordSuccess()),
    );
  }

  /// Handles the sign-out event.
  /// Calls the sign-out use case and emits either [AuthFailure] or [AuthSignOutSuccess].
  Future<void> _onAuthSignOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _authSignOut(NoParams());

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSignOutSuccess()),
    );
  }

  /// Handles the session check event.
  /// Calls the session use case and emits either [AuthSessionFailure] or [AuthSessionSuccess].
  Future<void> _onAuthCheckSessionEvent(
    AuthCheckSessionEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authSession(NoParams());

    result.fold(
      (failure) => emit(AuthSessionFailure()),
      (currentUser) => _emitAuthSuccess(currentUser, emit),
      // {
      //   // Update the app user cubit with the current user and emit session success.
      //   _appUserCubit.currentUser(currentUser);
      //   emit(AuthSignInSuccess(uid: currentUser.uid));

      // }
    );
  }

  //
  void _emitAuthSuccess(User? user, Emitter<AuthState> emit) {
    _appUserCubit.currentUser(user);
    emit(AuthSignInSuccess(uid: user!.uid));
  }
}
