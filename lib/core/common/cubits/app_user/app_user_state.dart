part of 'app_user_cubit.dart';

/// Base class for all app user states.
@immutable
sealed class AppUserState {}

/// State representing an uninitialized or logged-out user.
final class AppUserInitial extends AppUserState {}

/// State representing a logged-in user.
final class AppUserLoggedIn extends AppUserState {}
