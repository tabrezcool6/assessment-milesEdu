import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for retrieving the current user session.
/// This decouples the session retrieval logic from the repository.
class AuthSession implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  AuthSession(this.authRepository);

  /// Executes the session retrieval logic by calling the repository.
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getUserSession();
  }
}

// Note:
// The `NoParams` class is defined in the universal `UseCase` class
// to avoid duplication, as it is used across multiple use cases.
