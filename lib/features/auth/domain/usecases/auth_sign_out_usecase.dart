import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for signing out the current user.
/// 
/// This class encapsulates the sign-out logic, decoupling it from the repository
/// and making it reusable and testable. It takes [NoParams] as input and returns
/// either a [Failure] or void on success.
class AuthSignOut implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the [AuthRepository] dependency.
  AuthSignOut(this.authRepository);

  /// Executes the sign-out logic by calling the repository.
  ///
  /// [params] - No parameters required for this use case.
  /// Returns [Either] a [Failure] on error or [void] on success.
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
