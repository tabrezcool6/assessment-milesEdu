part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class TaskCreateEvent extends TaskEvent {
  final String userUid;
  final String title;
  final String description;
  final DateTime date;

  TaskCreateEvent({
    required this.userUid,
    required this.title,
    required this.description,
    required this.date,
  });
}

class TaskUpdateEvent extends TaskEvent {
  final String userUid;
  final String taskUid;
  final String? title;
  final String? description;
  final bool? isCompleted;
  final DateTime? dueDate;

  TaskUpdateEvent({
    required this.userUid,
    required this.taskUid,
    this.title,
    this.description,
    this.isCompleted,
    this.dueDate,
  });
}

class TaskReadEvent extends TaskEvent {
  final String userUid;

  TaskReadEvent({required this.userUid});
}

class TaskDeleteEvent extends TaskEvent {
  final String userUid;
  final String taskUid;

  TaskDeleteEvent({required this.userUid, required this.taskUid});
}
