import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_delete_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_read_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_create_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_update_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'task_event.dart';
part 'task_state.dart';

/// Bloc for managing task-related events and states.
/// Handles task creation, reading, updating, and deletion.
/// 
/// This Bloc coordinates the UI and domain layers, emitting states in response to events.
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskCreateUsecase _taskCreateUsecase;
  final TaskReadUseCase _taskReadUsecase;
  final TaskUpdateUsecase _taskUpdateUsecase;
  final TaskDeleteUseCase _taskDeleteUsecase;

  /// Constructor to inject dependencies for all task use cases.
  TaskBloc({
    required TaskCreateUsecase taskCreateUsecase,
    required TaskReadUseCase taskReadUseCase,
    required TaskUpdateUsecase taskUpdateUsecase,
    required TaskDeleteUseCase taskDeleteUsecase,
  })  : _taskCreateUsecase = taskCreateUsecase,
        _taskReadUsecase = taskReadUseCase,
        _taskUpdateUsecase = taskUpdateUsecase,
        _taskDeleteUsecase = taskDeleteUsecase,
        super(TaskInitial()) {
    // Register event handlers for each event type.
    on<TaskEvent>((_, emit) => emit(TaskLoading()));
    // Register handler for creating a task.
    on<TaskCreateEvent>(_onTaskCreateEvent);

    // Register handler for reading tasks.
    on<TaskReadEvent>(_onTaskReadEvent);

    // Register handler for updating a task.
    on<TaskUpdateEvent>(_onTaskUpdateEvent);

    // Register handler for deleting a task.
    on<TaskDeleteEvent>(_onTaskDeleteEvent);
  }

  /// Handles the creation of a new task.
  /// Calls the create use case and emits either [TaskCreateSuccess] or [TaskFailure].
  Future<void> _onTaskCreateEvent(
    TaskCreateEvent event,
    Emitter<TaskState> emit,
  ) async {
    final response = await _taskCreateUsecase(
      TaskCreateParams(
        userUid: event.userUid,
        title: event.title,
        description: event.description,
        date: event.date,
      ),
    );
    response.fold(
      (failure) => emit(TaskFailure(failure.message)),
      (_) => emit(TaskCreateSuccess()),
    );
  }

  /// Handles reading all tasks for a user.
  /// Calls the read use case and emits either [TaskReadSuccess] or [TaskFailure].
  Future<void> _onTaskReadEvent(
    TaskReadEvent event,
    Emitter<TaskState> emit,
  ) async {
    final response = await _taskReadUsecase(
      TaskReadParams(userUid: event.userUid),
    );
    response.fold(
      (failure) => emit(TaskFailure(failure.message)),
      (tasks) => emit(TaskReadSuccess(tasks)),
    );
  }

  /// Handles updating an existing task.
  /// Calls the update use case and emits either [TaskUpdateSuccess] or [TaskFailure].
  Future<void> _onTaskUpdateEvent(
    TaskUpdateEvent event,
    Emitter<TaskState> emit,
  ) async {
    final response = await _taskUpdateUsecase(
      TaskUpdateParams(
        userUid: event.userUid,
        taskUid: event.taskUid,
        title: event.title,
        description: event.description,
        isCompleted: event.isCompleted,
        dueDate: event.dueDate,
      ),
    );
    response.fold(
      (failure) => emit(TaskFailure(failure.message)),
      (_) => emit(TaskUpdateSuccess()),
    );
  }

  /// Handles deleting a task.
  /// Calls the delete use case and emits either [TaskDeleteSuccess] or [TaskFailure].
  Future<void> _onTaskDeleteEvent(
    TaskDeleteEvent event,
    Emitter<TaskState> emit,
  ) async {
    final response = await _taskDeleteUsecase(
      TaskDeleteParams(userUid: event.userUid, taskUid: event.taskUid),
    );
    response.fold(
      (failure) => emit(TaskFailure(failure.message)),
      (_) => emit(TaskDeleteSuccess()),
    );
  }
}
