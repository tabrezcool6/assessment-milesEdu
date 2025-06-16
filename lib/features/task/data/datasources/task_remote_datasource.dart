import 'package:assessment_miles_edu/core/error/exceptions.dart';
import 'package:assessment_miles_edu/features/task/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class defining the contract for the Task data source.
/// This abstraction allows for easy replacement or extension of the backend in the future.
abstract class TaskFirebaseDataSource {
  /// Creates a new task for the specified user.
  Future<void> createTask({
    required String userUid,
    required TaskModel taskModel,
  });

  /// Reads all tasks for the specified user.
  Future<List<TaskModel>> readTask({required String userUid});

  /// Updates an existing task for the specified user.
  Future<void> updateTask({
    required String userUid,
    required String taskUid,
    required String? title,
    required String? description,
    required bool? isCompleted,
    required DateTime? dueDate,
  });

  /// Deletes a task for the specified user.
  Future<void> deleteTask({required String userUid, required String taskUid});
}

/// Implementation of the Task data source using Firebase Firestore.
class TaskFirebaseDataSourceImplementation implements TaskFirebaseDataSource {
  final FirebaseFirestore firebaseFirestore;

  /// Constructor to inject the FirebaseFirestore instance.
  TaskFirebaseDataSourceImplementation(this.firebaseFirestore);

  /// Creates a new task document in Firestore under the user's collection.
  /// Throws [ServerExceptions] if the operation fails.
  @override
  Future<void> createTask({
    required String userUid,
    required TaskModel taskModel,
  }) async {
    try {
      await firebaseFirestore
          .collection(userUid)
          .doc(taskModel.id)
          .set(taskModel.toJson());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  /// Reads all tasks for the user, sorted by due date descending.
  /// Throws [ServerExceptions] if the operation fails.
  @override
  Future<List<TaskModel>> readTask({
    required String userUid,
    String? taskUid, // Not used, but could be used for filtering a specific task.
  }) async {
    try {
      // Fetch all documents (tasks) for the user.
      final tasks = await firebaseFirestore.collection(userUid).get();

      // Sort tasks by dueDate descending.
      final sortedDocs = tasks.docs
        ..sort((a, b) => b['dueDate'].compareTo(a['dueDate'] as String));

      // Convert Firestore documents to TaskModel instances.
      return sortedDocs.map((doc) => TaskModel.fromJson(doc.data())).toList();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  /// Updates fields of an existing task document in Firestore.
  /// Only non-null fields are updated.
  /// Throws [ServerExceptions] if the operation fails.
  @override
  Future<void> updateTask({
    required String userUid,
    required String taskUid,
    required String? title,
    required String? description,
    required bool? isCompleted,
    required DateTime? dueDate,
  }) async {
    try {
      // Prepare the update map, only including non-null fields.
      final updateData = <String, dynamic>{
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (isCompleted != null) 'isCompleted': isCompleted,
        if (dueDate != null) 'dueDate': dueDate.toIso8601String(),
      };

      // Update the document with merge to preserve other fields.
      await firebaseFirestore
          .collection(userUid)
          .doc(taskUid)
          .set(updateData, SetOptions(merge: true));
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  /// Deletes a task document from Firestore.
  /// Throws [ServerExceptions] if the operation fails.
  @override
  Future<void> deleteTask({
    required String userUid,
    required String taskUid,
  }) async {
    try {
      await firebaseFirestore.collection(userUid).doc(taskUid).delete();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

}
