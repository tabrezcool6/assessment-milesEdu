import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';

/// Use case for signing up a user with email and password.
/// 
/// This class encapsulates the sign-up logic, decoupling it from the repository
/// and making it reusable and testable. It takes [AuthSignUpParams] as input and returns
/// either a [Failure] or void on success.
class AuthSignUpWithEmail implements UseCase<User, AuthSignUpParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the [AuthRepository] dependency.
  AuthSignUpWithEmail(this.authRepository);

  /// Executes the sign-up logic by calling the repository.
  ///
  /// [params] - The parameters required to sign up.
  /// Returns [Either] a [Failure] on error or [void] on success.
  @override
  Future<Either<Failure, User>> call(AuthSignUpParams params) async {
    return await authRepository.signUpWithEmail(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters required for signing up a user.
/// 
/// Contains the user's name, email, and password.
class AuthSignUpParams {
  /// The user's display name.
  final String name;

  /// The user's email address.
  final String email;

  /// The user's password.
  final String password;

  /// Constructor to initialize the name, email, and password.
  AuthSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
