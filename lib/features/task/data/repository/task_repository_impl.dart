import 'package:assessment_miles_edu/core/constants/constants.dart';
import 'package:assessment_miles_edu/core/error/exceptions.dart';
import 'package:assessment_miles_edu/core/error/failures.dart';
import 'package:assessment_miles_edu/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:assessment_miles_edu/features/task/data/datasources/task_remote_datasource.dart';
import 'package:assessment_miles_edu/features/task/data/models/task_model.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:uuid/uuid.dart';

/// Implementation of the AuthRepository interface.
/// Handles authentication logic by interacting with the data source and managing errors.
class TaskRepositoryImplementation implements TaskRepository {
  final TaskFirebaseDataSource taskFirebaseDataSource;
  final InternetConnection internetConnection;

  /// Constructor for dependency injection.
  TaskRepositoryImplementation(
    this.taskFirebaseDataSource,
    this.internetConnection,
  );

  /// Handles user sign-up with email and password.
  @override
  Future<Either<Failure, void>> createTask({
    required String userUid,
    required String title,
    required String description,
    required DateTime date,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      final taskModel = TaskModel(
        id: const Uuid().v1(),
        title: title,
        description: description,
        dueDate: date,
      );
      await taskFirebaseDataSource.createTask(
        userUid: userUid,
        taskModel: taskModel,
      );
      return right(null);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> readTask({
    required String userUid,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }

      final tasks = await taskFirebaseDataSource.readTask(userUid: userUid);

      return right(tasks);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask({
    required String userUid,
    required String taskUid,
    required String? title,
    required String? description,
    required bool? isCompleted,
    required DateTime? dueDate,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      await taskFirebaseDataSource.updateTask(
        userUid: userUid,
        taskUid: taskUid,
        title: title,
        description: description,
        isCompleted: isCompleted,
        dueDate: dueDate,
      );
      return right(null);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask({
    required String userUid,
    required String taskUid,
  }) async {
    try {
      if (!await internetConnection.hasInternetAccess) {
        return left(Failure(Constants.noInternetConnectionMessage));
      }
      await taskFirebaseDataSource.deleteTask(
        userUid: userUid,
        taskUid: taskUid,
      );
      return right(null);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  /// Handles user sign-in with email and password.
  // @override
  // Future<Either<Failure, void>> signInWithEmail({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     if (!await internetConnection.hasInternetAccess) {
  //       return left(Failure(Constants.noInternetConnectionMessage));
  //     }
  //     await authFirebaseDataSource.signInWithEmail(
  //       email: email,
  //       password: password,
  //     );
  //     return right(null);
  //   } on ServerExceptions catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

  // /// Retrieves the current user session.
  // @override
  // Future<Either<Failure, User>> getUserSession() async {
  //   try {
  //     if (!await internetConnection.hasInternetAccess) {
  //       return left(Failure(Constants.noInternetConnectionMessage));
  //     }
  //     final userSession = authFirebaseDataSource.getCurrentUserSession;
  //     if (userSession == null) {
  //       return left(Failure('User is not logged in'));
  //     }
  //     return right(userSession);
  //   } on ServerExceptions catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

  // /// Sends a password reset email to the user.
  // @override
  // Future<Either<Failure, void>> resetPassword({required String email}) async {
  //   try {
  //     if (!await internetConnection.hasInternetAccess) {
  //       return left(Failure(Constants.noInternetConnectionMessage));
  //     }
  //     await authFirebaseDataSource.resetPassword(email: email);
  //     return right(null);
  //   } on ServerExceptions catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

  // /// Signs out the current user.
  // @override
  // Future<Either<Failure, void>> signOut() async {
  //   try {
  //     await authFirebaseDataSource.signOut();
  //     return right(null);
  //   } on ServerExceptions catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }
}
