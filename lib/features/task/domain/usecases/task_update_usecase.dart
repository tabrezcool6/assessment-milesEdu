import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';

/// Use case for signing up a user with email and password.
/// Decouples the sign-up logic from the repository.
class TaskUpdateUsecase implements UseCase<void, TaskUpdateParams> {
  final TaskRepository taskRepository;

  /// Constructor to inject the `AuthRepository` dependency.
  TaskUpdateUsecase(this.taskRepository);

  /// Executes the sign-up logic by calling the repository.
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

/// Parameters required for signing up a user.
/// Contains the user's name, email, and password.
class TaskUpdateParams {
  final String userUid;
  final String taskUid;
  String? title;
  String? description;
  bool? isCompleted;
  DateTime? dueDate;

  /// Constructor to initialize the name, email, and password.
  TaskUpdateParams({
    required this.userUid,
    required this.taskUid,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueDate,
  });
}
