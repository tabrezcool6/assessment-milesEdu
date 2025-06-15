import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
import 'package:assessment_miles_edu/core/utils.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_base_deco.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  ///
  final _formKey = GlobalKey<FormState>();
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
        if (state is AuthFailure) {
          Utils.showSnackBar(context, state.message);
        } else if (state is AuthResetPasswordSuccess) {
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

                // Reset Input
                AuthInputFieldWidget(
                  label: 'E-mail',
                  controller: _emailController,
                ),

                const SizedBox(height: 42),

                if (state is AuthLoading)
                  const Loader()
                else
                  AuthPrimaryButton(
                    btnTitle: 'Confirm',
                    onPressed: _resetPasswordOnTap,
                    // onPressed: () {
                    //   // Handle login logic here
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => const Homepage()),
                    //   );
                    // },
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
