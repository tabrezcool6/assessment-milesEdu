import 'package:assessment_miles_edu/core/constants/constants.dart';
import 'package:assessment_miles_edu/core/error/exceptions.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Implementation of the [AuthRepository] interface.
/// Handles authentication logic by interacting with the remote data source,
/// performing connectivity checks, and mapping exceptions to failures.
class AuthRepositoryImplementation implements AuthRepository {
  final AuthFirebaseDataSource authFirebaseDataSource;
  final InternetConnection internetConnection;

  /// Constructor for dependency injection of data source and connectivity checker.
  AuthRepositoryImplementation(
    this.authFirebaseDataSource,
    this.internetConnection,
  );

  /// Handles user sign-up with email and password.
  /// Checks for internet connectivity before proceeding.
  /// Returns [Failure] if there is no connection or a server error occurs.
  @override
  Future<Either<Failure, User>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      await authFirebaseDataSource.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );

      final userSession = authFirebaseDataSource.getCurrentUserSession;

      if (userSession == null) {
        return left(Failure('User session is null after sign-up'));
      }

      return right(userSession);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  /// Handles user sign-in with email and password.
  /// Checks for internet connectivity before proceeding.
  /// Returns [Failure] if there is no connection or a server error occurs.
  @override
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      await authFirebaseDataSource.signInWithEmail(
        email: email,
        password: password,
      );

      final userSession = authFirebaseDataSource.getCurrentUserSession;

      if (userSession == null) {
        return left(Failure('User session is null after sign-in'));
      }
      return right(userSession);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  /// Retrieves the current user session.
  /// Checks for internet connectivity before proceeding.
  /// Returns [Failure] if there is no connection, no user is logged in, or a server error occurs.
  @override
  Future<Either<Failure, User>> getUserSession() async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      final userSession = authFirebaseDataSource.getCurrentUserSession;
      if (userSession == null) {
        return left(Failure('User is not logged in'));
      }
      return right(userSession);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  /// Sends a password reset email to the user.
  /// Checks for internet connectivity before proceeding.
  /// Returns [Failure] if there is no connection or a server error occurs.
  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      await authFirebaseDataSource.resetPassword(email: email);
      return right(null);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  /// Signs out the current user.
  /// Returns [Failure] if a server error occurs.
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authFirebaseDataSource.signOut();
      return right(null);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
