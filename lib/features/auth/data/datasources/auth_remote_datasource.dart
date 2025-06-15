import 'package:assessment_miles_edu/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class defining the contract for authentication data source.
/// This allows flexibility to switch to a different backend in the future.
abstract class AuthFirebaseDataSource {
  /// Gets the current user session.
  User? get getCurrentUserSession;

  /// Signs up a user with email and password.
  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  /// Signs in a user with email and password.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sends a password reset email to the user.
  Future<void> resetPassword({required String email});

  /// Signs out the current user.
  Future<void> signOut();
}

/// Implementation of the authentication data source using Firebase.
class AuthFirebaseDataSourceImplementation implements AuthFirebaseDataSource {
  final FirebaseAuth firebaseAuth;

  /// Constructor to inject the FirebaseAuth instance.
  AuthFirebaseDataSourceImplementation(this.firebaseAuth);

  /// Gets the current user session.
  @override
  User? get getCurrentUserSession => firebaseAuth.currentUser;

  /// Signs up a user with email and password.
  @override
  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  /// Signs in a user with email and password.
  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  /// Sends a password reset email to the user.
  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  /// Signs out the current user.
  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  /// Handles FirebaseAuth exceptions and maps them to custom exceptions.
  ServerExceptions _handleFirebaseAuthException(FirebaseAuthException e) {
    print('////// FirebaseAuthException: $e');
    switch (e.code) {
      case 'weak-password':
        return ServerExceptions('The password provided is too weak.');
      case 'email-already-in-use':
        return ServerExceptions('The account already exists for that email.');
      case 'invalid-email':
        return ServerExceptions('The email address is badly formatted.');
      case 'operation-not-allowed':
        return ServerExceptions('Operation not allowed.');
      case 'user-disabled':
        return ServerExceptions('User disabled.');
      case 'user-not-found':
        return ServerExceptions('No user found for that email.');
      case 'wrong-password':
        return ServerExceptions('Wrong password provided for that user.');
      case 'invalid-credential':
        return ServerExceptions(
          'The supplied auth credential is incorrect, malformed or has expired.',
        );
      default:
        return ServerExceptions('An error occurred. Please try again later.');
    }
  }
}
