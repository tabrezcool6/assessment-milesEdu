// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
// import 'package:assessment_miles_edu/core/common/widgets/primary_button.dart';
// import 'package:assessment_miles_edu/core/theme/app_pallete.dart';
// import 'package:assessment_miles_edu/core/theme/text_styles.dart';
// import 'package:assessment_miles_edu/core/utils.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/pages/in.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_greetings_widget.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_text_field.dart';

// /// Page for signing up a new user.
// /// Allows the user to enter their name, email, and password to create an account.
// class SignUpPage extends StatefulWidget {
//   /// Route for navigating to the Sign Up Page.
//   static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   /// Disposes resources when the page is destroyed.
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   /// Builds the UI for the Sign Up Page.
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           Utils.showSnackBar(context, state.message);
//         } else if (state is AuthSignUpSuccess) {
//           Utils.showSnackBar(context, "Account created successfully!");
//           Navigator.pushAndRemoveUntil(
//             context,
//             SignInPage.route(),
//             (context) => false,
//           );
//         }
//       },
//       builder: (context, state) => _buildSignUpBody(context, state),
//     );
//   }

//   /// Builds the body of the Sign Up Page.
//   Widget _buildSignUpBody(BuildContext context, AuthState state) {
//     return Scaffold(
//       body: Form(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildTextInputFields(),
//               _buildSignUpButtonSection(state),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Builds the input fields for name, email, and password.
//   Column _buildTextInputFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 64.0),
//           child: AuthGreetingsWidget(
//             title: "Register Now",
//             subTitle: "Let's get your account created.",
//           ),
//         ),
//         TextStyles.size14cWhiteRegular400("Name"),
//         AuthTextField(hintText: 'Enter your name', controller: _nameController),
//         const SizedBox(height: 24.0),
//         TextStyles.size14cWhiteRegular400("Email"),
//         AuthTextField(
//           hintText: 'Enter your email',
//           controller: _emailController,
//         ),
//         const SizedBox(height: 24.0),
//         TextStyles.size14cWhiteRegular400("Password"),
//         AuthTextField(
//           hintText: 'Enter your password',
//           controller: _passwordController,
//         ),
//       ],
//     );
//   }

//   /// Builds the sign-up button and "Already have an account?" section.
//   Padding _buildSignUpButtonSection(AuthState state) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 32.0),
//       child: Column(
//         children: [
//           if (state is AuthLoading)
//             const Loader()
//           else
//             PrimaryButton(
//               text: 'Sign Up',
//               width: double.infinity,
//               onPressed: _signUpOnTap,
//             ),
//           const SizedBox(height: 6.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextStyles.size14cWhiteRegular400("Already have an account? "),
//               GestureDetector(
//                 onTap:
//                     () => Navigator.pushAndRemoveUntil(
//                       context,
//                       SignInPage.route(),
//                       (context) => false,
//                     ),
//                 child: TextStyles.size14cWhiteRegular400(
//                   "Sign In",
//                   color: AppPallete.primaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   /// Handles the sign-up button tap.
//   /// Triggers the sign-up event with the entered name, email, and password.
//   void _signUpOnTap() {
//     FocusScope.of(context).unfocus();
//     context.read<AuthBloc>().add(
//       AuthSignUpWithEmailEvent(
//         name: _nameController.text.trim(),
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       ),
//     );
//   }
// }
