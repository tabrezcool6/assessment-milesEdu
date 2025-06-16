import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';

/// Use case for signing in a user with email and password.
/// 
/// This class encapsulates the sign-in logic, decoupling it from the repository
/// and making it reusable and testable. It takes [AuthSignInParams] as input and returns
/// either a [Failure] or void on success.
class AuthSignInWithEmail implements UseCase<void, AuthSignInParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the [AuthRepository] dependency.
  AuthSignInWithEmail(this.authRepository);

  /// Executes the sign-in logic by calling the repository.
  ///
  /// [params] - The parameters required to sign in.
  /// Returns [Either] a [Failure] on error or [void] on success.
  @override
  Future<Either<Failure, void>> call(AuthSignInParams params) async {
    return await authRepository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters required for signing in a user.
/// 
/// Contains the user's email and password.
class AuthSignInParams {
  /// The user's email address.
  final String email;

  /// The user's password.
  final String password;

  /// Constructor to initialize the email and password.
  AuthSignInParams({required this.email, required this.password});
}
