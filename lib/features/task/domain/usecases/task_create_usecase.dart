import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';

/// Use case for creating a new task for a user.
/// 
/// This class encapsulates the logic for creating a task, decoupling it from the repository
/// and making it reusable and testable. It takes [TaskCreateParams] as input and returns
/// either a [Failure] or void on success.
class TaskCreateUsecase implements UseCase<void, TaskCreateParams> {
  final TaskRepository taskRepository;

  /// Constructor to inject the [TaskRepository] dependency.
  TaskCreateUsecase(this.taskRepository);

  /// Executes the create task logic by delegating to the repository.
  ///
  /// [params] - The parameters required to create a task.
  /// Returns [Either] a [Failure] on error or [void] on success.
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

/// Parameters required for creating a new task.
/// 
/// Contains the user's UID, task title, description, and due date.
class TaskCreateParams {
  /// The unique identifier of the user who owns the task.
  final String userUid;

  /// The title of the task.
  final String title;

  /// The description of the task.
  final String description;

  /// The due date of the task.
  final DateTime date;

  /// Constructor to initialize all required fields for task creation.
  TaskCreateParams({
    required this.userUid,
    required this.title,
    required this.description,
    required this.date,
  });
}
