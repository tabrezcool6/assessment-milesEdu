import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';

/// Use case for updating an existing task for a user.
/// 
/// This class encapsulates the logic for updating a task, decoupling it from the repository
/// and making it reusable and testable. It takes [TaskUpdateParams] as input and returns
/// either a [Failure] or void on success.
class TaskUpdateUsecase implements UseCase<void, TaskUpdateParams> {
  final TaskRepository taskRepository;

  /// Constructor to inject the [TaskRepository] dependency.
  TaskUpdateUsecase(this.taskRepository);

  /// Executes the update task logic by delegating to the repository.
  ///
  /// [params] - The parameters required to update a task.
  /// Returns [Either] a [Failure] on error or [void] on success.
  @override
  Future<Either<Failure, void>> call(TaskUpdateParams params) async {
    return await taskRepository.updateTask(
      userUid: params.userUid,
      taskUid: params.taskUid,
      title: params.title,
      description: params.description,
      isCompleted: params.isCompleted,
      dueDate: params.dueDate,
    );
  }
}

/// Parameters required for updating a task.
/// 
/// Contains the user's UID, task's UID, and any fields to update (all optional except IDs).
class TaskUpdateParams {
  /// The unique identifier of the user who owns the task.
  final String userUid;

  /// The unique identifier of the task to be updated.
  final String taskUid;

  /// (Optional) New title for the task.
  final String? title;

  /// (Optional) New description for the task.
  final String? description;

  /// (Optional) New completion status for the task.
  final bool? isCompleted;

  /// (Optional) New due date for the task.
  final DateTime? dueDate;

  /// Constructor to initialize all fields for task update.
  /// Only non-null fields will be updated.
  TaskUpdateParams({
    required this.userUid,
    required this.taskUid,
    this.title,
    this.description,
    this.isCompleted,
    this.dueDate,
  });
}
