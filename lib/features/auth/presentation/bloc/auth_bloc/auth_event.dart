part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

/// Event for signing up a user with email and password.
final class AuthSignUpWithEmailEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpWithEmailEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

/// Event for signing in a user with email and password.
final class AuthSignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInWithEmailEvent({required this.email, required this.password});
}

/// Event for sending a password reset email to the user.
final class AuthForgotPassword extends AuthEvent {
  final String email;

  AuthForgotPassword({required this.email});
}

/// Event for checking the current user session.
final class AuthCheckSessionEvent extends AuthEvent {}

/// Event for signing out the current user.
final class AuthSignOutEvent extends AuthEvent {}
