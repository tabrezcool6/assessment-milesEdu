import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
import 'package:assessment_miles_edu/core/utils.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_base_deco.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/home_page.dart';
import 'package:assessment_miles_edu/features/auth/presentation/pages/reset_password_page.dart';
import 'package:assessment_miles_edu/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  ///
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signInOnTap() {
    if (_formKey.currentState!.validate()) {
      // Handle login logic here
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Homepage()),
      // );
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
        AuthSignInWithEmailEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  /// Disposes resources when the page is destroyed.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          Utils.showSnackBar(context, state.message);
        } else if (state is AuthSignInSuccess) {
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   Homepage.route(),
          //   (context) => false,
          // );

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
                  const AuthTitleWidget(title: "Welcome Back"),
                  const SizedBox(height: 30),

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
                    isDone: true,
                    obsecureText: true,
                  ),
                  const SizedBox(height: 10),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: AuthTextButtonWidget(
                      btnTitle: "Forgot Password?",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (state is AuthLoading)
                    const Loader()
                  else
                    // Login Button
                    AuthPrimaryButton(
                      btnTitle: "Login",
                      onPressed: _signInOnTap,
                    ),
                  const SizedBox(height: 20),

                  // Sign Up Link
                  AuthTextButtonWidget(
                    btnTitle: "Don't have an account? Sign Up",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
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
