import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';

/// [TaskModel] is a data model that extends [TaskEntity] and provides
/// serialization and deserialization methods for working with JSON and Firestore.
///
/// This class is used for data transfer and storage, while [TaskEntity]
/// represents the domain entity.
class TaskModel extends TaskEntity {
  /// Constructs a [TaskModel] with the given properties.
  ///
  /// [id], [title], [description], and [dueDate] are required.
  /// [isCompleted] defaults to false if not provided.
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dueDate,
    super.isCompleted = false,
  });

  /// Converts this [TaskModel] instance to a JSON-compatible map.
  ///
  /// Useful for storing the task in Firestore or sending over the network.
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(), // Store as ISO8601 string for consistency
      'isCompleted': isCompleted,
    };
  }

  /// Creates a [TaskModel] from a JSON map.
  ///
  /// Throws [FormatException] if [dueDate] is not a valid ISO8601 string.
  /// If [isCompleted] is missing, defaults to false.
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  /// Returns a copy of this [TaskModel] with the given fields replaced by new values.
  ///
  /// This is useful for updating only specific fields while keeping the rest unchanged.
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
