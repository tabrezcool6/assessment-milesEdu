import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for signing out the current user.
/// Decouples the sign-out logic from the repository.
class TaskReadUseCase implements UseCase<void, TaskReadParams> {
  final TaskRepository taskRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  TaskReadUseCase(this.taskRepository);

  /// Executes the sign-out logic by calling the repository.
  @override
  Future<Either<Failure, List<TaskEntity>>> call(TaskReadParams params) async {
    return await taskRepository.readTask(userUid: params.userUid);
  }
}

/// Parameters required for signing up a user.
/// Contains the user's name, email, and password.
class TaskReadParams {
  final String userUid;

  /// Constructor to initialize the name, email, and password.
  TaskReadParams({required this.userUid});
}
