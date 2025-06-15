import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';

/// Use case for signing in a user with email and password.
/// Decouples the sign-in logic from the repository.
class AuthSignInWithEmail implements UseCase<void, AuthSignInParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  AuthSignInWithEmail(this.authRepository);

  /// Executes the sign-in logic by calling the repository.
  @override
  Future<Either<Failure, void>> call(AuthSignInParams params) async {
    return await authRepository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters required for signing in a user.
/// Contains the user's email and password.
class AuthSignInParams {
  final String email;
  final String password;

  /// Constructor to initialize the email and password.
  AuthSignInParams({required this.email, required this.password});
}
