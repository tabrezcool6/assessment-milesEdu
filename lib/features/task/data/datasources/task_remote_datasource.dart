import 'package:assessment_miles_edu/core/error/exceptions.dart';
import 'package:assessment_miles_edu/features/task/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class defining the contract for authentication data source.
/// This allows flexibility to switch to a different backend in the future.
abstract class TaskFirebaseDataSource {
  /// Signs out the current user.
  Future<void> createTask({
    required String userUid,
    required TaskModel taskModel,
  });

  Future<List<TaskModel>> readTask({required String userUid});

  Future<void> updateTask({
    required String userUid,
    required String taskUid,
    required String? title,
    required String? description,
    required bool? isCompleted,
    required DateTime? dueDate,
  });

  Future<void> deleteTask({required String userUid, required String taskUid});
}

/// Implementation of the authentication data source using Firebase.
class TaskFirebaseDataSourceImplementation implements TaskFirebaseDataSource {
  final FirebaseFirestore firebaseFirestore;

  /// Constructor to inject the FirebaseAuth instance.
  TaskFirebaseDataSourceImplementation(this.firebaseFirestore);

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

      // return 'success';
      // } on PostgrestException catch (e) {
      //   throw ServerExceptions(e.message);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<List<TaskModel>> readTask({
    required String userUid,
    String? taskUid,
  }) async {
    try {
      final tasks = await firebaseFirestore.collection(userUid).get();

      final sortedDocs = tasks.docs
        ..sort((a, b) => b['dueDate'].compareTo(a['dueDate'] as String));

      return sortedDocs.map((doc) => TaskModel.fromJson(doc.data())).toList();

      // return 'success';
      // } on PostgrestException catch (e) {
      //   throw ServerExceptions(e.message);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

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
      await firebaseFirestore.collection(userUid).doc(taskUid).set({
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'dueDate': dueDate?.toIso8601String(),
      }, SetOptions(merge: true));

      // return 'success';
      // } on PostgrestException catch (e) {
      //   throw ServerExceptions(e.message);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

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

  /// Handles FirebaseAuth exceptions and maps them to custom exceptions.
  // ServerExceptions _handleFirebaseAuthException(FirebaseAuthException e) {
  //   print('////// FirebaseAuthException: $e');
  //   switch (e.code) {
  //     case 'weak-password':
  //       return ServerExceptions('The password provided is too weak.');
  //     case 'email-already-in-use':
  //       return ServerExceptions('The account already exists for that email.');
  //     case 'invalid-email':
  //       return ServerExceptions('The email address is badly formatted.');
  //     case 'operation-not-allowed':
  //       return ServerExceptions('Operation not allowed.');
  //     case 'user-disabled':
  //       return ServerExceptions('User disabled.');
  //     case 'user-not-found':
  //       return ServerExceptions('No user found for that email.');
  //     case 'wrong-password':
  //       return ServerExceptions('Wrong password provided for that user.');
  //     case 'invalid-credential':
  //       return ServerExceptions(
  //         'The supplied auth credential is incorrect, malformed or has expired.',
  //       );
  //     default:
  //       return ServerExceptions('An error occurred. Please try again later.');
  //   }
  // }
}
