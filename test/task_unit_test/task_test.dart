import 'package:assessment_miles_edu/core/error/exceptions.dart';
import 'package:assessment_miles_edu/features/task/data/datasources/task_remote_datasource.dart';
import 'package:assessment_miles_edu/features/task/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock classes for Firestore and its related types.
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockSetOptions extends Mock implements SetOptions {}

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDoc;
  late TaskFirebaseDataSourceImplementation dataSource;

  // Set up a new mock Firestore and data source before each test.
  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDoc = MockDocumentReference();
    dataSource = TaskFirebaseDataSourceImplementation(mockFirestore);
  });

  group('Task Create Unit test:', () {
    test(
      /// Should register a task in Firestore when createTask is called.
      'given TaskFirebaseDataSourceImplementation class when `Create Task` method is called then task should register in firestore',
      () async {
        final taskModel = TaskModel(
          id: '1',
          title: 'Test',
          description: 'desc',
          dueDate: DateTime.now(),
          isCompleted: false,
        );

        // Mock Firestore collection and document behavior.
        when(() => mockFirestore.collection(any())).thenReturn(mockCollection);
        when(() => mockCollection.doc(any())).thenReturn(mockDoc);
        when(() => mockDoc.set(any())).thenAnswer((_) async {});

        await dataSource.createTask(userUid: 'user1', taskModel: taskModel);

        // Verify correct Firestore calls.
        verify(() => mockFirestore.collection('user1')).called(1);
        verify(() => mockCollection.doc('1')).called(1);
        verify(() => mockDoc.set(taskModel.toJson())).called(1);
      },
    );
    test(
      /// Should throw ServerExceptions when Firestore throws an error.
      'given TaskFirebaseDataSourceImplementation class when `Create Task` method throws an error then should throw ServerExceptions',
      () async {
        final taskModel = TaskModel(
          id: '1',
          title: 'Test',
          description: 'desc',
          dueDate: DateTime.now(),
          isCompleted: false,
        );

        when(
          () => mockFirestore.collection(any()),
        ).thenThrow(Exception('Firestore error'));

        expect(
          () => dataSource.createTask(userUid: 'user1', taskModel: taskModel),
          throwsA(isA<ServerExceptions>()),
        );
      },
    );

    group('Task Read Unit Test:', () {
      test(
        /// Should return a list of TaskModel from Firestore.
        'given TaskFirebaseDataSourceImplementation class when `Read Task` method is called then should return a list of TaskModel from Firestore',
        () async {
          final mockQuerySnapshot = MockQuerySnapshot();
          final mockDoc1 = MockQueryDocumentSnapshot();
          final mockDoc2 = MockQueryDocumentSnapshot();

          final taskJson1 = {
            'id': '1',
            'title': 'Task 1',
            'description': 'desc1',
            'dueDate': DateTime.now().toIso8601String(),
            'isCompleted': false,
          };
          final taskJson2 = {
            'id': '2',
            'title': 'Task 2',
            'description': 'desc2',
            'dueDate': DateTime.now().toIso8601String(),
            'isCompleted': true,
          };

          // Mock Firestore to return two documents.
          when(
            () => mockFirestore.collection(any()),
          ).thenReturn(mockCollection);
          when(
            () => mockCollection.get(),
          ).thenAnswer((_) async => mockQuerySnapshot);
          when(() => mockQuerySnapshot.docs).thenReturn([mockDoc1, mockDoc2]);
          when(() => mockDoc1.data()).thenReturn(taskJson1);
          when(() => mockDoc2.data()).thenReturn(taskJson2);
          when(() => mockDoc1['dueDate']).thenReturn(taskJson1['dueDate']);
          when(() => mockDoc2['dueDate']).thenReturn(taskJson2['dueDate']);

          final result = await dataSource.readTask(userUid: 'user1');

          expect(result, isA<List<TaskModel>>());
          expect(result.length, 2);
          expect(result[0].id, isNotNull);
        },
      );

      test(
        /// Should throw ServerExceptions when Firestore throws an error.
        'given TaskFirebaseDataSourceImplementation class when `Read Task` method throws an error then should throw ServerExceptions',
        () async {
          when(
            () => mockFirestore.collection(any()),
          ).thenThrow(Exception('Firestore error'));

          expect(
            () => dataSource.readTask(userUid: 'user1'),
            throwsA(isA<ServerExceptions>()),
          );
        },
      );
    });

    group('Task Update', () {
      test(
        /// Should update the task document with correct data in Firestore.
        'given TaskFirebaseDataSourceImplementation class when `Update Task` method is called then should update the task document with correct data in Firestore',
        () async {
          when(
            () => mockFirestore.collection(any()),
          ).thenReturn(mockCollection);
          when(() => mockCollection.doc(any())).thenReturn(mockDoc);
          when(() => mockDoc.set(any(), any())).thenAnswer((_) async {});

          await dataSource.updateTask(
            userUid: 'user1',
            taskUid: 'task1',
            title: 'Updated',
            description: null,
            isCompleted: true,
            dueDate: null,
          );

          verify(() => mockFirestore.collection('user1')).called(1);
          verify(() => mockCollection.doc('task1')).called(1);
          verify(
            () => mockDoc.set({'title': 'Updated', 'isCompleted': true}, any()),
          ).called(1);
        },
      );

      test(
        /// Should throw ServerExceptions when Firestore throws an error.
        'given TaskFirebaseDataSourceImplementation class when `Update Task` method throws an error then should throw ServerExceptions',
        () async {
          when(
            () => mockFirestore.collection(any()),
          ).thenThrow(Exception('Firestore error'));

          expect(
            () => dataSource.updateTask(
              userUid: 'user1',
              taskUid: 'task1',
              title: 'Updated',
              description: null,
              isCompleted: true,
              dueDate: null,
            ),
            throwsA(isA<ServerExceptions>()),
          );
        },
      );
    });

    group('Task Delete Unit Test:', () {
      test(
        /// Should delete the task document in Firestore.
        'given TaskFirebaseDataSourceImplementation class when `Delete Task` method is called then should delete the task document in Firestore',
        () async {
          when(
            () => mockFirestore.collection(any()),
          ).thenReturn(mockCollection);
          when(() => mockCollection.doc(any())).thenReturn(mockDoc);
          when(() => mockDoc.delete()).thenAnswer((_) async {});

          await dataSource.deleteTask(userUid: 'user1', taskUid: 'task1');

          verify(() => mockFirestore.collection('user1')).called(1);
          verify(() => mockCollection.doc('task1')).called(1);
          verify(() => mockDoc.delete()).called(1);
        },
      );

      test(
        /// Should throw ServerExceptions when Firestore throws an error.
        'given TaskFirebaseDataSourceImplementation class when `Delete Task` method throws an error then should throw ServerExceptions',
        () async {
          when(
            () => mockFirestore.collection(any()),
          ).thenThrow(Exception('Firestore error'));

          expect(
            () => dataSource.deleteTask(userUid: 'user1', taskUid: 'task1'),
            throwsA(isA<ServerExceptions>()),
          );
        },
      );
    });
  });
}
