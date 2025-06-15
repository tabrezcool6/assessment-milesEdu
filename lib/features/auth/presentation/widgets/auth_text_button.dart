import 'package:assessment_miles_edu/features/auth/presentation/pages/reset_password_page.dart';
import 'package:flutter/material.dart';

class AuthTextButtonWidget extends StatelessWidget {
  const AuthTextButtonWidget({
    required this.btnTitle,
    required this.onPressed,
    super.key,
  });

  final String btnTitle;
  final VoidCallback onPressed;

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
