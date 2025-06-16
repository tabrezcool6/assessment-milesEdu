import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';

/// Use case for resetting a user's password.
/// 
/// This class encapsulates the reset password logic, decoupling it from the repository
/// and making it reusable and testable. It takes [ResetPasswordParams] as input and returns
/// either a [Failure] or void on success.
class AuthResetPassword implements UseCase<void, ResetPasswordParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the [AuthRepository] dependency.
  AuthResetPassword(this.authRepository);

  /// Executes the reset password logic by calling the repository.
  ///
  /// [params] - The parameters required to reset the password.
  /// Returns [Either] a [Failure] on error or [void] on success.
  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await authRepository.resetPassword(email: params.email);
  }
}

/// Parameters required for resetting a user's password.
/// 
/// Contains the user's email address.
class ResetPasswordParams {
  /// The email address of the user whose password is to be reset.
  final String email;

  /// Constructor to initialize the email parameter.
  ResetPasswordParams({required this.email});
}
