part of 'auth_bloc.dart';

@immutable
/// Base class for all authentication-related states emitted by [AuthBloc].
sealed class AuthState {}

/// Initial state of the authentication process.
/// Emitted when the Bloc is first created or reset.
final class AuthInitial extends AuthState {}

/// State indicating that an authentication-related operation is in progress.
/// Useful for showing loading indicators during any auth process.
final class AuthLoading extends AuthState {}

/// State indicating that the user has successfully signed in.
final class AuthSuccess extends AuthState {
  /// The unique identifier of the authenticated user.
  final String uid;

  /// Constructor to initialize the authenticated user's UID.
  AuthSuccess({required this.uid});
}

/// State indicating that the session check has failed.
/// Emitted when no user session is found or session retrieval fails.
final class AuthSessionFailure extends AuthState {}

/// State indicating that the user has successfully signed out.
final class AuthSignOutSuccess extends AuthState {}

/// State indicating that the password reset email was sent successfully.
final class AuthResetPasswordSuccess extends AuthState {}

/// State indicating that an authentication-related operation has failed.
/// Contains an error [message] describing the failure.
final class AuthFailure extends AuthState {
  /// The error message describing the failure.
  final String message;

  /// Constructor to initialize the failure message.
  AuthFailure(this.message);
}
