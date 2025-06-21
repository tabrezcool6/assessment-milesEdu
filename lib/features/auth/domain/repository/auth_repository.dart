import 'dart:async';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

/// Domain Layer: Defines the contract for the authentication repository.
/// 
/// This interface ensures that any implementation must provide these methods,
/// enabling separation of concerns and easier testing/mocking.
abstract interface class AuthRepository {
  /// Handles user sign-up with email and password.
  ///
  /// [name] - The display name of the user.
  /// [email] - The user's email address.
  /// [password] - The user's password.
  ///
  /// Returns [Either] a [Failure] on error or [void] on success.
  Future<Either<Failure, User>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  /// Handles user sign-in with email and password.
  ///
  /// [email] - The user's email address.
  /// [password] - The user's password.
  ///
  /// Returns [Either] a [Failure] on error or [void] on success.
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Retrieves the current user session.
  ///
  /// Returns [Either] a [Failure] on error or the [User] object on success.
  Future<Either<Failure, User>> getUserSession();

  /// Sends a password reset email to the user.
  ///
  /// [email] - The user's email address.
  ///
  /// Returns [Either] a [Failure] on error or [void] on success.
  Future<Either<Failure, void>> resetPassword({required String email});

  /// Signs out the current user.
  ///
  /// Returns [Either] a [Failure] on error or [void] on success.
  Future<Either<Failure, void>> signOut();
}
