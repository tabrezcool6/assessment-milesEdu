part of 'auth_bloc.dart';

@immutable
/// Base class for all authentication-related events handled by [AuthBloc].
sealed class AuthEvent {}

/// Event for signing up a user with email and password.
/// Carries the user's name, email, and password for registration.
final class AuthSignUpWithEmailEvent extends AuthEvent {
  /// The user's display name.
  final String name;

  /// The user's email address.
  final String email;

  /// The user's password.
  final String password;

  /// Constructs an [AuthSignUpWithEmailEvent] with all required fields.
  AuthSignUpWithEmailEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

/// Event for signing in a user with email and password.
/// Carries the user's email and password for authentication.
final class AuthSignInWithEmailEvent extends AuthEvent {
  /// The user's email address.
  final String email;

  /// The user's password.
  final String password;

  /// Constructs an [AuthSignInWithEmailEvent] with required credentials.
  AuthSignInWithEmailEvent({required this.email, required this.password});
}

/// Event for sending a password reset email to the user.
/// Carries the user's email address for password reset.
final class AuthForgotPassword extends AuthEvent {
  /// The user's email address.
  final String email;

  /// Constructs an [AuthForgotPassword] event with the user's email.
  AuthForgotPassword({required this.email});
}

/// Event for checking the current user session.
/// Used to verify if a user is already authenticated.
final class AuthCheckSessionEvent extends AuthEvent {}

/// Event for signing out the current user.
/// Triggers the sign-out process.
final class AuthSignOutEvent extends AuthEvent {}
