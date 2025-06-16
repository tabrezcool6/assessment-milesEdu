part of 'task_bloc.dart';

@immutable
/// Base class for all task-related events handled by [TaskBloc].
sealed class TaskEvent {}

/// Event to trigger the creation of a new task.
///
/// Carries all required information to create a task for a specific user.
class TaskCreateEvent extends TaskEvent {
  /// The unique identifier of the user who owns the task.
  final String userUid;

  /// The title of the new task.
  final String title;

  /// The description of the new task.
  final String description;

  /// The due date of the new task.
  final DateTime date;

  /// Constructs a [TaskCreateEvent] with all required fields.
  TaskCreateEvent({
    required this.userUid,
    required this.title,
    required this.description,
    required this.date,
  });
}

/// Event to trigger the retrieval of all tasks for a user.
///
/// Carries the user's unique identifier.
class TaskReadEvent extends TaskEvent {
  /// The unique identifier of the user whose tasks are to be retrieved.
  final String userUid;

  /// Constructs a [TaskReadEvent] with the required user UID.
  TaskReadEvent({required this.userUid});
}

/// Event to trigger the update of an existing task.
///
/// Carries the task's unique identifier and any fields to update (all optional except IDs).
class TaskUpdateEvent extends TaskEvent {
  /// The unique identifier of the user who owns the task.
  final String userUid;

  /// The unique identifier of the task to update.
  final String taskUid;

  /// (Optional) New title for the task.
  final String? title;

  /// (Optional) New description for the task.
  final String? description;

  /// (Optional) New completion status for the task.
  final bool? isCompleted;

  /// (Optional) New due date for the task.
  final DateTime? dueDate;

  /// Constructs a [TaskUpdateEvent] with required IDs and optional update fields.
  TaskUpdateEvent({
    required this.userUid,
    required this.taskUid,
    this.title,
    this.description,
    this.isCompleted,
    this.dueDate,
  });
}

/// Event to trigger the deletion of a task.
///
/// Carries the user's UID and the task's UID to be deleted.
class TaskDeleteEvent extends TaskEvent {
  /// The unique identifier of the user who owns the task.
  final String userUid;

  /// The unique identifier of the task to delete.
  final String taskUid;

  /// Constructs a [TaskDeleteEvent] with required user and task UIDs.
  TaskDeleteEvent({required this.userUid, required this.taskUid});
}
