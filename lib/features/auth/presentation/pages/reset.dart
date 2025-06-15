// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
// import 'package:assessment_miles_edu/core/common/widgets/primary_button.dart';
// import 'package:assessment_miles_edu/core/theme/text_styles.dart';
// import 'package:assessment_miles_edu/core/utils.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_greetings_widget.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_text_field.dart';

// /// Page for resetting the user's password.
// /// Allows the user to enter their email and request a password reset link.
// class ResetPasswordPage extends StatefulWidget {
//   /// Route for navigating to the Reset Password Page.
//   static route() =>
//       MaterialPageRoute(builder: (context) => const ResetPasswordPage());

//   const ResetPasswordPage({super.key});

//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// }

// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   final FocusNode _emailFocusNode = FocusNode();
//   final TextEditingController _emailController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   /// Initializes the page and sets focus on the email input field.
//   @override
//   void initState() {
//     super.initState();
//     _emailFocusNode.requestFocus();
//   }

//   /// Disposes resources when the page is destroyed.
//   @override
//   void dispose() {
//     _emailFocusNode.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   /// Handles the reset password button tap.
//   /// Validates the form and triggers the password reset event.
//   void _resetPasswordOnTap() {
//     if (formKey.currentState!.validate()) {
//       context.read<AuthBloc>().add(
//         AuthForgotPassword(email: _emailController.text.trim()),
//       );
//     }
//   }

//   /// Builds the UI for the Reset Password Page.
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           Utils.showSnackBar(context, state.message);
//         } else if (state is AuthResetPasswordSuccess) {
//           Utils.showSnackBar(
//             context,
//             "Password reset link has been sent to your email.",
//           );
//           _emailController.clear();
//           Navigator.pop(context);
//         }
//       },
//       builder: (context, state) => _buildResetPasswordBody(context, state),
//     );
//   }

//   /// Builds the body of the Reset Password Page.
//   Widget _buildResetPasswordBody(BuildContext context, AuthState state) {
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [_buildTextInputWidget(), _buildResetButtonWidget(state)],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Builds the input field for the email address.
//   Padding _buildTextInputWidget() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 101.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AuthGreetingsWidget(title: "Reset Password"),
//           const SizedBox(height: 64.0),
//           TextStyles.size14cWhiteRegular400("Email"),
//           AuthTextField(
//             hintText: 'Enter your email',
//             controller: _emailController,
//           ),
//         ],
//       ),
//     );
//   }

//   /// Builds the reset password button.
//   Padding _buildResetButtonWidget(AuthState state) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 32.0),
//       child: Column(
//         children: [
//           if (state is AuthLoading)
//             const Loader()
//           else
//             PrimaryButton(
//               text: 'Continue',
//               width: double.infinity,
//               onPressed: _resetPasswordOnTap,
//             ),
//         ],
//       ),
//     );
//   }
// }
