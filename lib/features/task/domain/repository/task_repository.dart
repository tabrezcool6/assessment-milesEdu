import 'dart:async';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';

/// Domain Layer: Defines the contract for the authentication repository.
/// This interface ensures that any implementation must provide these methods.
abstract interface class TaskRepository {
  /// Handles user sign-up with email and password.
  /// Returns either a `Failure` or a `void` on success.
  Future<Either<Failure, void>> createTask({
    required String userUid,
    required String title,
    required String description,
    required DateTime date,
  });

  Future<Either<Failure, List<TaskEntity>>> readTask({required String userUid});

  Future<Either<Failure, void>> updateTask({
    required String userUid,
    required String taskUid,
    required String? title,
    required String? description,
    required bool? isCompleted,
    required DateTime? dueDate,
  });

  Future<Either<Failure, void>> deleteTask({
    required String userUid,
    required String taskUid,
  });
}
