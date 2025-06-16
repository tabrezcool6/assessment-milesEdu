import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for deleting a task for a user.
/// 
/// This class encapsulates the logic for deleting a task, decoupling it from the repository
/// and making it reusable and testable. It takes [TaskDeleteParams] as input and returns
/// either a [Failure] or void on success.
class TaskDeleteUseCase implements UseCase<void, TaskDeleteParams> {
  final TaskRepository taskRepository;

  /// Constructor to inject the [TaskRepository] dependency.
  TaskDeleteUseCase(this.taskRepository);

  /// Executes the delete task logic by delegating to the repository.
  ///
  /// [params] - The parameters required to delete a task.
  /// Returns [Either] a [Failure] on error or [void] on success.
  @override
  Future<Either<Failure, void>> call(TaskDeleteParams params) async {
    return await taskRepository.deleteTask(
      userUid: params.userUid,
      taskUid: params.taskUid,
    );
  }
}

/// Parameters required for deleting a task.
/// 
/// Contains the user's UID and the task's UID.
class TaskDeleteParams {
  /// The unique identifier of the user who owns the task.
  final String userUid;

  /// The unique identifier of the task to be deleted.
  final String taskUid;

  /// Constructor to initialize all required fields for task deletion.
  TaskDeleteParams({required this.userUid, required this.taskUid});
}
