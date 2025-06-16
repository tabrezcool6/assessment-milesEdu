import 'package:assessment_miles_edu/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:assessment_miles_edu/core/theme/app_theme.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/home_page.dart';
import 'package:assessment_miles_edu/features/auth/presentation/pages/sign_in_page.dart';
import 'package:assessment_miles_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // Initialize the Flutter binding to ensure that the framework is ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies for the application.
  // This includes Firebase, authentication, home features, and core services.
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        // Provide AppUserCubit for user session management
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),

        // Provide AuthBloc for authentication-related events
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),

        // Provide AuthBloc for authentication-related events
        BlocProvider(create: (_) => serviceLocator<TaskBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheckSessionEvent());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assessment - Miles Education Flutter App...',
      theme: AppTheme.themeData(context),

      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          // Check if the user is logged in
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          // Navigate to Homepage if logged in, otherwise to SignInPage
          if (isLoggedIn) {
            return const Homepage();
          }
          return SignInPage();
        },
      ),
    );
  }
}
