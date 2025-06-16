import 'package:assessment_miles_edu/core/error/exceptions.dart';
import 'package:assessment_miles_edu/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock classes for FirebaseAuth and related types.
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late AuthFirebaseDataSourceImplementation dataSource;

  // Set up a new mock and data source before each test.
  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthFirebaseDataSourceImplementation(mockFirebaseAuth);
  });

  group('Auth getCurrentUserSession Unit Test:', () {
    test(
      /// Should return the current user if available.
      'returns the current user when getCurrentUserSession is called',
      () {
        final mockUser = MockUser();
        when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

        final result = dataSource.getCurrentUserSession;

        expect(result, mockUser);
      },
    );
  });

  group('Auth signUpWithEmail Unit Test:', () {
    test(
      /// Should call createUserWithEmailAndPassword with correct params.
      'calls createUserWithEmailAndPassword when signUpWithEmail is called',
      () async {
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => MockUserCredential());

        await dataSource.signUpWithEmail(
          name: 'Test',
          email: 'test@email.com',
          password: 'password123',
        );

        verify(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'test@email.com',
            password: 'password123',
          ),
        ).called(1);
      },
    );

    test(
      /// Should throw ServerExceptions on FirebaseAuthException.
      'throws ServerExceptions when FirebaseAuthException occurs in signUpWithEmail',
      () async {
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

        expect(
          () => dataSource.signUpWithEmail(
            name: 'Test',
            email: 'test@email.com',
            password: 'password123',
          ),
          throwsA(isA<ServerExceptions>()),
        );
      },
    );
  });

  group('signInWithEmail', () {
    test(
      /// Should call signInWithEmailAndPassword with correct params.
      'calls signInWithEmailAndPassword when signInWithEmail is called',
      () async {
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => MockUserCredential());

        await dataSource.signInWithEmail(
          email: 'test@email.com',
          password: 'password123',
        );

        verify(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@email.com',
            password: 'password123',
          ),
        ).called(1);
      },
    );

    test(
      /// Should throw ServerExceptions on FirebaseAuthException.
      'throws ServerExceptions when FirebaseAuthException occurs in signInWithEmail',
      () async {
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

        expect(
          () => dataSource.signInWithEmail(
            email: 'test@email.com',
            password: 'password123',
          ),
          throwsA(isA<ServerExceptions>()),
        );
      },
    );
  });

  group('resetPassword', () {
    test(
      /// Should call sendPasswordResetEmail with correct email.
      'calls sendPasswordResetEmail when resetPassword is called',
      () async {
        when(
          () => mockFirebaseAuth.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenAnswer((_) async => Future.value());

        await dataSource.resetPassword(email: 'test@email.com');

        verify(
          () => mockFirebaseAuth.sendPasswordResetEmail(email: 'test@email.com'),
        ).called(1);
      },
    );

    test(
      /// Should throw ServerExceptions on FirebaseAuthException.
      'throws ServerExceptions when FirebaseAuthException occurs in resetPassword',
      () async {
        when(
          () => mockFirebaseAuth.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

        expect(
          () => dataSource.resetPassword(email: 'test@email.com'),
          throwsA(isA<ServerExceptions>()),
        );
      },
    );
  });

  group('Auth Sign Out Unit Test:', () {
    test(
      /// Should call signOut on FirebaseAuth.
      'calls signOut when signOut is called',
      () async {
        when(
          () => mockFirebaseAuth.signOut(),
        ).thenAnswer((_) async => Future.value());

        await dataSource.signOut();

        verify(() => mockFirebaseAuth.signOut()).called(1);
      },
    );
  });

  test(
    /// Should throw ServerExceptions on generic error during signOut.
    'throws ServerExceptions when signOut throws an error',
    () async {
      when(
        () => mockFirebaseAuth.signOut(),
      ).thenThrow(Exception('Sign out error'));

      expect(() => dataSource.signOut(), throwsA(isA<ServerExceptions>()));
    },
  );
}
