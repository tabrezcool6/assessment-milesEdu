import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
import 'package:assessment_miles_edu/core/utils.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_base_deco.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Page for user sign-up.
/// 
/// Provides a form for users to enter their username, email, and password,
/// and handles registration logic via [AuthBloc]. Displays feedback and navigation based on state.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  /// Key for the sign-up form.
  final _formKey = GlobalKey<FormState>();

  /// Controller for the username input field.
  final TextEditingController _usernameController = TextEditingController();

  /// Controller for the email input field.
  final TextEditingController _emailController = TextEditingController();

  /// Controller for the password input field.
  final TextEditingController _passwordController = TextEditingController();

  /// Handles the sign-up button tap.
  /// Validates the form and triggers the sign-up event.
  void _signUpOnTap() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
        AuthSignUpWithEmailEvent(
          name: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  /// Disposes controllers when the page is destroyed.
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Show error message if sign-up fails.
        if (state is AuthFailure) {
          Utils.showSnackBar(context, state.message);
        } 
        // Show success message and navigate to home page if sign-up succeeds.
        else if (state is AuthSignUpSuccess) {
          Utils.showSnackBar(context, "Account created successfully!");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        }
      },
      builder: (context, state) {
        return AuthBaseDecorationClass(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  AuthTitleWidget(title: "Create Account"),
                  const SizedBox(height: 30),

                  // Username Input
                  AuthInputFieldWidget(
                    label: 'Username',
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 20),

                  // Email Input
                  AuthInputFieldWidget(
                    label: 'E-mail',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  AuthInputFieldWidget(
                    label: 'Password',
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 30),

                  // Show loader while processing, otherwise show sign up button
                  if (state is AuthLoading)
                    const Loader()
                  else
                    AuthPrimaryButton(
                      btnTitle: "Sign Up",
                      onPressed: _signUpOnTap,
                    ),
                  const SizedBox(height: 20),

                  // Login Link
                  AuthTextButtonWidget(
                    btnTitle: "Already have an account? Login",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
