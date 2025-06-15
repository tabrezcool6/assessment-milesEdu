part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

/// Initial state of the authentication process.
final class TaskInitial extends TaskState {}

/// State indicating that an authentication-related operation is in progress.
final class TaskReadLoading extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskFailure extends TaskState {
  final String message;

  /// Constructor to initialize the failure message.
  TaskFailure(this.message);
}

final class TaskSuccess extends TaskState {}

final class TaskCreateSuccess extends TaskState {}

final class TaskUpdateSuccess extends TaskState {}

final class TaskDeleteSuccess extends TaskState {}

final class TaskReadSuccess extends TaskState {
  final List<TaskEntity> tasks;

  /// Constructor to initialize the list of tasks.
  TaskReadSuccess(this.tasks);
}
