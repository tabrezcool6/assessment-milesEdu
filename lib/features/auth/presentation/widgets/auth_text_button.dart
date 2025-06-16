import 'package:flutter/material.dart';

/// A reusable text button widget for authentication pages.
///
/// This widget is used for secondary actions such as "Forgot Password?" or navigation links.
/// It accepts a title and a callback for the button press.
class AuthTextButtonWidget extends StatelessWidget {
  /// The text to display on the button.
  final String btnTitle;

  /// The callback function to execute when the button is pressed.
  final VoidCallback onPressed;

  /// Creates an [AuthTextButtonWidget] with the given title and callback.
  const AuthTextButtonWidget({
    required this.btnTitle,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnTitle,
        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
      ),
    );
  }
}
