import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for signing out the current user.
/// Decouples the sign-out logic from the repository.
class TaskDeleteUseCase implements UseCase<void, TaskDeleteParams> {
  final TaskRepository taskRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  TaskDeleteUseCase(this.taskRepository);

  /// Executes the sign-out logic by calling the repository.
  @override
  Future<Either<Failure, void>> call(TaskDeleteParams params) async {
    return await taskRepository.deleteTask(
      userUid: params.userUid,
      taskUid: params.taskUid,
    );
  }
}

/// Parameters required for signing up a user.
/// Contains the user's name, email, and password.
class TaskDeleteParams {
  final String userUid;
  final String taskUid;

  /// Constructor to initialize the name, email, and password.
  TaskDeleteParams({required this.userUid, required this.taskUid});
}
