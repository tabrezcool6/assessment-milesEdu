/// [TaskEntity] represents the core domain entity for a task.
///
/// This class defines the essential properties of a task and is used throughout
/// the domain and data layers. It is designed to be immutable and easily extendable.
class TaskEntity {
  /// Unique identifier for the task.
  final String id;

  /// Title or name of the task.
  final String title;

  /// Detailed description of the task.
  final String description;

  /// The due date and time for the task.
  final DateTime dueDate;

  /// Indicates whether the task is completed.
  /// Defaults to false if not specified.
  final bool isCompleted;

  /// Constructs a [TaskEntity] with the given properties.
  ///
  /// [id], [title], [description], and [dueDate] are required.
  /// [isCompleted] is optional and defaults to false.
  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });
}
