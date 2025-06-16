import 'package:flutter/material.dart';

/// A reusable primary button widget for authentication forms.
///
/// This button is styled for consistency across sign-in, sign-up, and reset password pages.
/// It accepts a title and a callback for the button press.
class AuthPrimaryButton extends StatelessWidget {
  /// The text to display on the button.
  final String btnTitle;

  /// The callback function to execute when the button is pressed.
  final VoidCallback onPressed;

  /// Creates an [AuthPrimaryButton] with the given title and callback.
  const AuthPrimaryButton({
    required this.btnTitle,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.indigo.shade400,
        elevation: 5,
      ),
      child: Text(
        btnTitle,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
