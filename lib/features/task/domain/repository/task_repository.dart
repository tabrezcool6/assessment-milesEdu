import 'dart:async';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';

/// Domain Layer: Defines the contract for the task repository.
/// 
/// This interface ensures that any implementation must provide these methods,
/// enabling separation of concerns and easier testing/mocking.
abstract interface class TaskRepository {
  /// Creates a new task for the specified user.
  ///
  /// [userUid] - The unique identifier of the user.
  /// [title] - The title of the task.
  /// [description] - The description of the task.
  /// [date] - The due date of the task.
  ///
  /// Returns [Either] a [Failure] on error or [void] on success.
  Future<Either<Failure, void>> createTask({
    required String userUid,
    required String title,
    required String description,
    required DateTime date,
  });

  /// Retrieves all tasks for the specified user.
  ///
  /// [userUid] - The unique identifier of the user.
  ///
  /// Returns [Either] a [Failure] on error or a list of [TaskEntity] on success.
  Future<Either<Failure, List<TaskEntity>>> readTask({required String userUid});

  /// Updates an existing task for the specified user.
  ///
  /// [userUid] - The unique identifier of the user.
  /// [taskUid] - The unique identifier of the task.
  /// [title] - (Optional) New title for the task.
  /// [description] - (Optional) New description for the task.
  /// [isCompleted] - (Optional) New completion status.
  /// [dueDate] - (Optional) New due date.
  ///
  /// Only non-null fields will be updated.
  /// Returns [Either] a [Failure] on error or [void] on success.
  Future<Either<Failure, void>> updateTask({
    required String userUid,
    required String taskUid,
    required String? title,
    required String? description,
    required bool? isCompleted,
    required DateTime? dueDate,
  });

  /// Deletes a task for the specified user.
  ///
  /// [userUid] - The unique identifier of the user.
  /// [taskUid] - The unique identifier of the task to delete.
  ///
  /// Returns [Either] a [Failure] on error or [void] on success.
  Future<Either<Failure, void>> deleteTask({
    required String userUid,
    required String taskUid,
  });
}
