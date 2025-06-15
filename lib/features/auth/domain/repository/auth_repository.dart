import 'dart:async';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

/// Domain Layer: Defines the contract for the authentication repository.
/// This interface ensures that any implementation must provide these methods.
abstract interface class AuthRepository {
  /// Handles user sign-up with email and password.
  /// Returns either a `Failure` or a `void` on success.
  Future<Either<Failure, void>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  /// Handles user sign-in with email and password.
  /// Returns either a `Failure` or a `void` on success.
  Future<Either<Failure, void>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Retrieves the current user session.
  /// Returns either a `Failure` or the `User` object on success.
  Future<Either<Failure, User>> getUserSession();

  /// Sends a password reset email to the user.
  /// Returns either a `Failure` or a `void` on success.
  Future<Either<Failure, void>> resetPassword({required String email});

  /// Signs out the current user.
  /// Returns either a `Failure` or a `void` on success.
  Future<Either<Failure, void>> signOut();
}
