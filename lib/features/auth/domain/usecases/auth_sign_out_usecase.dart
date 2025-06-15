import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for signing out the current user.
/// Decouples the sign-out logic from the repository.
class AuthSignOut implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  AuthSignOut(this.authRepository);

  /// Executes the sign-out logic by calling the repository.
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
