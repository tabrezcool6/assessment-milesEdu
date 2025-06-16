part of 'task_bloc.dart';

@immutable
/// Base class for all task-related states emitted by [TaskBloc].
sealed class TaskState {}

/// Initial state of the task management process.
/// Emitted when the Bloc is first created or reset.
final class TaskInitial extends TaskState {}

/// State indicating that a general task-related operation is in progress.
/// Can be used for create, update, or delete loading indicators.
final class TaskLoading extends TaskState {}

/// State indicating that a task-related operation has failed.
/// Contains an error [message] describing the failure.
final class TaskFailure extends TaskState {
  final String message;

  /// Constructor to initialize the failure message.
  TaskFailure(this.message);
}

/// State indicating that a generic task operation was successful.
final class TaskSuccess extends TaskState {}

/// State indicating that a task was successfully created.
final class TaskCreateSuccess extends TaskState {}

/// State indicating that a read (fetch) operation is in progress.
/// Useful for showing loading indicators when fetching tasks.
final class TaskReadLoading extends TaskState {}

/// State indicating that a task was successfully updated.
final class TaskUpdateSuccess extends TaskState {}

/// State indicating that a task was successfully deleted.
final class TaskDeleteSuccess extends TaskState {}

/// State indicating that tasks were successfully fetched.
/// Contains a list of [TaskEntity] representing the fetched tasks.
final class TaskReadSuccess extends TaskState {
  final List<TaskEntity> tasks;

  /// Constructor to initialize the list of tasks.
  TaskReadSuccess(this.tasks);
}
