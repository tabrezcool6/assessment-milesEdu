import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';

/// Use case for signing up a user with email and password.
/// Decouples the sign-up logic from the repository.
class TaskCreateUsecase implements UseCase<void, TaskCreateParams> {
  final TaskRepository taskRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  TaskCreateUsecase(this.taskRepository);

  /// Executes the sign-up logic by calling the repository.
  @override
  Future<Either<Failure, void>> call(TaskCreateParams params) async {
    return await taskRepository.createTask(
      userUid: params.userUid,
      title: params.title,
      description: params.description,
      date: params.date,
    );
  }
}

/// Parameters required for signing up a user.
/// Contains the user's name, email, and password.
class TaskCreateParams {
  final String userUid;
  final String title;
  final String description;
  final DateTime date;

  /// Constructor to initialize the name, email, and password.
  TaskCreateParams({
    required this.userUid,
    required this.title,
    required this.description,
    required this.date,
  });
}
