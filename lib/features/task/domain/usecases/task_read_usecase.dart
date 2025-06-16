import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/core/usecase/usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for retrieving all tasks for a user.
/// 
/// This class encapsulates the logic for reading tasks, decoupling it from the repository
/// and making it reusable and testable. It takes [TaskReadParams] as input and returns
/// either a [Failure] or a list of [TaskEntity] on success.
class TaskReadUseCase implements UseCase<List<TaskEntity>, TaskReadParams> {
  final TaskRepository taskRepository;

  /// Constructor to inject the [TaskRepository] dependency.
  TaskReadUseCase(this.taskRepository);

  /// Executes the read task logic by delegating to the repository.
  ///
  /// [params] - The parameters required to read tasks.
  /// Returns [Either] a [Failure] on error or a list of [TaskEntity] on success.
  @override
  Future<Either<Failure, List<TaskEntity>>> call(TaskReadParams params) async {
    return await taskRepository.readTask(userUid: params.userUid);
  }
}

/// Parameters required for reading tasks.
/// 
/// Contains the user's UID whose tasks are to be retrieved.
class TaskReadParams {
  /// The unique identifier of the user whose tasks are to be fetched.
  final String userUid;

  /// Constructor to initialize the user UID.
  TaskReadParams({required this.userUid});
}
