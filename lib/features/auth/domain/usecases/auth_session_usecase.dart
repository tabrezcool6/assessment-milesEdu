import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for retrieving the current user session.
/// 
/// This class encapsulates the logic for session retrieval, decoupling it from the repository
/// and making it reusable and testable. It takes [NoParams] as input and returns
/// either a [Failure] or a [User] on success.
class AuthSession implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the [AuthRepository] dependency.
  AuthSession(this.authRepository);

  /// Executes the session retrieval logic by calling the repository.
  ///
  /// [params] - No parameters required for this use case.
  /// Returns [Either] a [Failure] on error or the [User] on success.
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getUserSession();
  }
}

// Note:
// The `NoParams` class is defined in the universal `UseCase` class
// to avoid duplication, as it is used across multiple use cases.
