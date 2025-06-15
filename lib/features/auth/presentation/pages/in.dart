// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
// import 'package:assessment_miles_edu/core/common/widgets/primary_button.dart';
// import 'package:assessment_miles_edu/core/theme/text_styles.dart';
// import 'package:assessment_miles_edu/core/utils.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/pages/reset.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/pages/up.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_greetings_widget.dart';
// import 'package:assessment_miles_edu/features/auth/presentation/widgets/auth_text_field.dart';
// import 'package:assessment_miles_edu/features/home/presentation/pages/homepage.dart';

// /// Page for signing in a user.
// /// Allows the user to enter their email and password to log in.
// class SignInPage extends StatefulWidget {
//   /// Route for navigating to the Sign In Page.
//   static route() => MaterialPageRoute(builder: (context) => const SignInPage());

//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   /// Builds the UI for the Sign In Page.
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           Utils.showSnackBar(context, state.message);
//         } else if (state is AuthSignInSuccess) {
//           Navigator.pushAndRemoveUntil(
//             context,
//             Homepage.route(),
//             (context) => false,
//           );
//         }
//       },
//       builder: (context, state) => _buildSignInBody(context, state),
//     );
//   }

//   /// Builds the body of the Sign In Page.
//   Widget _buildSignInBody(BuildContext context, AuthState state) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [_buildTextInputFields(), _buildLoginButtonSection(state)],
//         ),
//       ),
//     );
//   }

//   /// Builds the input fields for email and password.
//   Column _buildTextInputFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AuthGreetingsWidget(title: "Welcome"),
//         const SizedBox(height: 64.0),
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
//         const SizedBox(height: 8.0),
//         Align(
//           alignment: Alignment.center,
//           child: GestureDetector(
//             onTap: () => Navigator.push(context, ResetPasswordPage.route()),
//             child: TextStyles.size14cBlueRegular400("Forgot Password?"),
//           ),
//         ),

//         const SizedBox(height: 24.0),
//       ],
//     );
//   }

//   /// Builds the login button and "Don't have an account?" section.
//   Column _buildLoginButtonSection(AuthState state) {
//     return Column(
//       children: [
//         if (state is AuthLoading)
//           const Loader()
//         else
//           PrimaryButton(
//             text: 'Login',
//             width: double.infinity,
//             onPressed: _signInWithEmail,
//           ),
//         const SizedBox(height: 6.0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextStyles.size14cWhiteRegular400("Don't have an account? "),
//             GestureDetector(
//               onTap: () => Navigator.push(context, SignUpPage.route()),
//               child: TextStyles.size14cBlueRegular400("Signup"),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   /// Handles the sign-in button tap.
//   /// Triggers the sign-in event with the entered email and password.
//   void _signInWithEmail() {
//     FocusScope.of(context).unfocus();
//     context.read<AuthBloc>().add(
//       AuthSignInWithEmailEvent(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       ),
//     );
//   }
// }
