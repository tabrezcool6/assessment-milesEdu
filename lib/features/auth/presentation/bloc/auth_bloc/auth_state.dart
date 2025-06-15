part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

/// Initial state of the authentication process.
final class AuthInitial extends AuthState {}

/// State indicating that an authentication-related operation is in progress.
final class AuthLoading extends AuthState {}

/// State indicating that the user is signing in with email and password.
final class AuthSignInWithEmailLoading extends AuthState {}

/// State indicating that the session check has failed.
final class AuthSessionFailure extends AuthState {}

/// State indicating that the session check was successful.
final class AuthSessionSuccess extends AuthState {
  final String uid;
  AuthSessionSuccess({required this.uid});
}

/// State indicating that the user has successfully signed out.
final class AuthSignOutSuccess extends AuthState {}

/// State indicating that the user has successfully signed in.
final class AuthSignInSuccess extends AuthState {}

/// State indicating that the user has successfully signed up.
final class AuthSignUpSuccess extends AuthState {}

/// State indicating that the password reset email was sent successfully.
final class AuthResetPasswordSuccess extends AuthState {}

/// State indicating that the user's email was successfully fetched.
final class AuthFetchUserSuccess extends AuthState {
  final String email;

  /// Constructor to initialize the fetched email.
  AuthFetchUserSuccess(this.email);
}

/// State indicating that an authentication-related operation has failed.
final class AuthFailure extends AuthState {
  final String message;

  /// Constructor to initialize the failure message.
  AuthFailure(this.message);
}
