import 'package:flutter/material.dart';

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    required this.btnTitle,
    required this.onPressed,
    super.key,
  });

  final String btnTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // () {
      //   // Handle login logic here
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const Homepage()),
      //   );
      // },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.indigo.shade400,
        elevation: 5,
      ),
      child: Text(
        btnTitle,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
