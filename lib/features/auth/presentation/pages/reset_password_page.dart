import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
import 'package:assessment_miles_edu/core/utils.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_base_deco.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Page for resetting a user's password.
/// 
/// This page provides a form for the user to enter their email address and request a password reset.
/// It listens to [AuthBloc] for state changes and displays appropriate feedback.
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  /// Key for the reset password form.
  final _formKey = GlobalKey<FormState>();

  /// Controller for the email input field.
  final TextEditingController _emailController = TextEditingController();

  /// Disposes resources when the page is destroyed.
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Handles the reset password button tap.
  /// Validates the form and triggers the password reset event.
  void _resetPasswordOnTap() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthForgotPassword(email: _emailController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Show error message if reset fails.
        if (state is AuthFailure) {
          Utils.showSnackBar(context, state.message);
        } 
        // Show success message and pop page if reset succeeds.
        else if (state is AuthResetPasswordSuccess) {
          Utils.showSnackBar(
            context,
            "Password reset link has been sent to your email.",
          );
          _emailController.clear();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AuthBaseDecorationClass(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                AuthTitleWidget(title: "Reset Password"),
                const SizedBox(height: 30),

                // Email input field
                AuthInputFieldWidget(
                  label: 'E-mail',
                  controller: _emailController,
                ),

                const SizedBox(height: 42),

                // Show loader while processing, otherwise show confirm button
                if (state is AuthLoading)
                  const Loader()
                else
                  AuthPrimaryButton(
                    btnTitle: 'Confirm',
                    onPressed: _resetPasswordOnTap,
                  ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
