import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';

/// Use case for signing up a user with email and password.
/// Decouples the sign-up logic from the repository.
class AuthSignUpWithEmail implements UseCase<void, AuthSignUpParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  AuthSignUpWithEmail(this.authRepository);

  /// Executes the sign-up logic by calling the repository.
  @override
  Future<Either<Failure, void>> call(AuthSignUpParams params) async {
    return await authRepository.signUpWithEmail(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters required for signing up a user.
/// Contains the user's name, email, and password.
class AuthSignUpParams {
  final String name;
  final String email;
  final String password;

  /// Constructor to initialize the name, email, and password.
  AuthSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
