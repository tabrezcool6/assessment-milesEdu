// Importing necessary packages and modules for dependency injection and feature initialization.
import 'package:assessment_miles_edu/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:assessment_miles_edu/core/common/services/connection_checker.dart';
import 'package:assessment_miles_edu/core/keys/firebase_options.dart';
import 'package:assessment_miles_edu/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:assessment_miles_edu/features/auth/data/repository/auth_repository_impl.dart';
import 'package:assessment_miles_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_sign_out_usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_sign_in_usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_session_usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_sign_up_usecase.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_reset_password.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/task/data/datasources/task_remote_datasource.dart';
import 'package:assessment_miles_edu/features/task/data/repository/task_repository_impl.dart';
import 'package:assessment_miles_edu/features/task/domain/repository/task_repository.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_delete_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_read_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_create_usecase.dart';
import 'package:assessment_miles_edu/features/task/domain/usecases/task_update_usecase.dart';
import 'package:assessment_miles_edu/features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Initialize the global service locator instance.
final serviceLocator = GetIt.instance;

/// Initializes all dependencies for the application.
/// This includes Firebase, authentication, home features, and core services.
Future<void> initDependencies() async {
  // Initialize Firebase services.
  await _initFirebase();

  // Initialize authentication-related dependencies.
  _initAuth();

  // Initialize home feature-related dependencies.
  _initTask();

  // Register core dependencies like connection checker and user cubits.
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImplementation(serviceLocator()),
  );
}

/// Initializes Firebase dependencies.
/// Registers FirebaseApp, FirebaseAuth, and FirebaseStorage as singletons.
Future<void> _initFirebase() async {
  final firebaseApp = await Firebase.initializeApp(
    /// not added KEY FILE in this project, generated in firebase console
    options: DefaultFirebaseOptions.currentPlatform,
  );

  serviceLocator
    ..registerLazySingleton(() => firebaseApp)
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance);
}

/// Initializes dependencies for authentication features.
/// Registers data sources, repositories, use cases, and the AuthBloc.
void _initAuth() {
  serviceLocator
    ..registerFactory<AuthFirebaseDataSource>(
      () => AuthFirebaseDataSourceImplementation(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImplementation(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => AuthSignUpWithEmail(serviceLocator()))
    ..registerFactory(() => AuthSignInWithEmail(serviceLocator()))
    ..registerFactory(() => AuthResetPassword(serviceLocator()))
    ..registerFactory(() => AuthSession(serviceLocator()))
    ..registerFactory(() => AuthSignOut(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        authSignUpWithEmail: serviceLocator(),
        authSignInWithEmail: serviceLocator(),
        authResetPassword: serviceLocator(),
        authSignOut: serviceLocator(),
        authSession: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

/// Initializes dependencies for home features.
/// Registers data sources, repositories, use cases, and the HomeBloc.
void _initTask() {
  serviceLocator
    ..registerFactory<TaskFirebaseDataSource>(
      () => TaskFirebaseDataSourceImplementation(serviceLocator()),
    )
    ..registerFactory<TaskRepository>(
      () => TaskRepositoryImplementation(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => TaskCreateUsecase(serviceLocator()))
    ..registerFactory(() => TaskReadUseCase(serviceLocator()))
    ..registerFactory(() => TaskUpdateUsecase(serviceLocator()))
    ..registerFactory(() => TaskDeleteUseCase(serviceLocator()))
    ..registerLazySingleton(
      () => TaskBloc(
        taskCreateUsecase: serviceLocator(),
        taskReadUseCase: serviceLocator(),
        taskUpdateUsecase: serviceLocator(),
        taskDeleteUsecase: serviceLocator(),
      ),
    );
}
