import 'package:assessment_miles_edu/core/constants/constants.dart';
import 'package:assessment_miles_edu/core/error/exceptions.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/features/task/data/datasources/task_remote_datasource.dart';
import 'package:assessment_miles_edu/features/task/data/models/task_model.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:uuid/uuid.dart';

/// Implementation of the [TaskRepository] interface.
/// Handles all task-related operations by interacting with the remote data source,
/// performing connectivity checks, and mapping exceptions to failures.
class TaskRepositoryImplementation implements TaskRepository {
  final TaskFirebaseDataSource taskFirebaseDataSource;
  final InternetConnection internetConnection;

  /// Constructor for dependency injection of data source and connectivity checker.
  TaskRepositoryImplementation(
    this.taskFirebaseDataSource,
    this.internetConnection,
  );

  /// Creates a new task for the specified user.
  ///
  /// Checks for internet connectivity before proceeding.
  /// Returns [Failure] if there is no connection or a server error occurs.
  @override
  Future<Either<Failure, void>> createTask({
    required String userUid,
    required String title,
    required String description,
    required DateTime date,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      // Generate a unique ID for the new task.
      final taskModel = TaskModel(
        id: const Uuid().v1(),
        title: title,
        description: description,
        dueDate: date,
      );
      await taskFirebaseDataSource.createTask(
        userUid: userUid,
        taskModel: taskModel,
      );
      return right(null);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  /// Retrieves all tasks for the specified user.
  ///
  /// Checks for internet connectivity before proceeding.
  /// Returns a list of [TaskEntity] on success, or [Failure] on error.
  @override
  Future<Either<Failure, List<TaskEntity>>> readTask({
    required String userUid,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      final tasks = await taskFirebaseDataSource.readTask(userUid: userUid);
      return right(tasks);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  /// Updates an existing task for the specified user.
  ///
  /// Only non-null fields will be updated.
  /// Checks for internet connectivity before proceeding.
  /// Returns [Failure] if there is no connection or a server error occurs.
  @override
  Future<Either<Failure, void>> updateTask({
    required String userUid,
    required String taskUid,
    required String? title,
    required String? description,
    required bool? isCompleted,
    required DateTime? dueDate,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      await taskFirebaseDataSource.updateTask(
        userUid: userUid,
        taskUid: taskUid,
        title: title,
        description: description,
        isCompleted: isCompleted,
        dueDate: dueDate,
      );
      return right(null);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  /// Deletes a task for the specified user.
  ///
  /// Checks for internet connectivity before proceeding.
  /// Returns [Failure] if there is no connection or a server error occurs.
  @override
  Future<Either<Failure, void>> deleteTask({
    required String userUid,
    required String taskUid,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      await taskFirebaseDataSource.deleteTask(
        userUid: userUid,
        taskUid: taskUid,
      );
      return right(null);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
