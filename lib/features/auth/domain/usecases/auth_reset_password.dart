import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';

/// Use case for resetting a user's password.
/// This decouples the reset password logic from the repository.
class AuthResetPassword implements UseCase<void, ResetPasswordParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  AuthResetPassword(this.authRepository);

  /// Executes the reset password logic by calling the repository.
  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await authRepository.resetPassword(email: params.email);
  }
}

/// Parameters required for resetting a user's password.
/// Contains the user's email address.
class ResetPasswordParams {
  final String email;

  /// Constructor to initialize the email parameter.
  ResetPasswordParams({required this.email});
}
