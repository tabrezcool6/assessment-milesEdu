import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_delete_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_read_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_create_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_update_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'task_event.dart';
part 'task_state.dart';

/// Bloc for managing authentication-related events and states.
/// Handles sign-up, sign-in, reset password, sign-out, and session management.
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskCreateUsecase _taskCreateUsecase;
  final TaskReadUseCase _taskReadUsecase;
  final TaskUpdateUsecase _taskUpdateUsecase;
  final TaskDeleteUseCase _taskDeleteUsecase;

  /// Constructor to inject dependencies for authentication use cases and app user management.
  TaskBloc({
    required TaskCreateUsecase taskCreateUsecase,
    required TaskReadUseCase taskReadUseCase,
    required TaskUpdateUsecase taskUpdateUsecase,
    required TaskDeleteUseCase taskDeleteUsecase,
  }) : _taskCreateUsecase = taskCreateUsecase,
       _taskReadUsecase = taskReadUseCase,
       _taskUpdateUsecase = taskUpdateUsecase,
       _taskDeleteUsecase = taskDeleteUsecase,

       super(TaskInitial()) {
    // Register event handlers
    on<TaskEvent>((_, emit) => emit(TaskLoading()));

    on<TaskCreateEvent>(_onTaskCreateEvent);

    on<TaskReadEvent>(_onTaskReadEvent);

    on<TaskUpdateEvent>(_onTaskUpdateEvent);

    on<TaskDeleteEvent>(_onTaskDeleteEvent);
  }

  /// Handles the sign-up event.
  /// Calls the sign-up use case and emits success or failure states.
  void _onTaskCreateEvent(
    TaskCreateEvent event,
    Emitter<TaskState> emit,
  ) async {
    // emit(TaskLoading());
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

  void _onTaskReadEvent(TaskReadEvent event, Emitter<TaskState> emit) async {
    final response = await _taskReadUsecase(
      TaskReadParams(userUid: event.userUid),
    );

    response.fold((failure) => emit(TaskFailure(failure.message)), (tasks) {
      emit(TaskReadSuccess(tasks));
    });
  }

  void _onTaskUpdateEvent(
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

  void _onTaskDeleteEvent(
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

  ///
}
