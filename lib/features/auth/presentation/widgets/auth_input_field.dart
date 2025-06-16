import 'package:flutter/material.dart';

/// A reusable input field widget for authentication forms.
///
/// Supports password visibility toggle, custom label, and validation.
/// Intended for use in sign-in, sign-up, and reset password pages.
class AuthInputFieldWidget extends StatefulWidget {
  /// The label to display above the input field.
  final String label;

  /// The controller for managing the input text.
  final TextEditingController controller;

  /// Whether this field is the last in the form (sets action to 'done').
  final bool isDone;

  /// Whether to obscure the text (for password fields).
  final bool obsecureText;

  /// Creates an [AuthInputFieldWidget] with the given parameters.
  const AuthInputFieldWidget({
    required this.label,
    required this.controller,
    this.isDone = false,
    this.obsecureText = false,
    super.key,
  });

  @override
  State<AuthInputFieldWidget> createState() => _AuthInputFieldWidgetState();
}

class _AuthInputFieldWidgetState extends State<AuthInputFieldWidget> {
  /// Tracks whether the input is obscured (for password fields).
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obsecureText; // Initialize with the provided value
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction:
          widget.isDone ? TextInputAction.done : TextInputAction.next,
      obscureText: _isObscured, // Use the state variable for password fields

      decoration: InputDecoration(
        // Show a visibility toggle icon for password fields
        suffixIcon: widget.label == 'Password'
            ? IconButton(
                icon: Icon(
                  _isObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured; // Toggle the obscure state
                  });
                },
              )
            : null,
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.label} cannot be empty';
        }
        return null;
      },
    );
  }
}

/// A reusable title widget for authentication pages.
///
/// Displays a large, bold, white title.
class AuthTitleWidget extends StatelessWidget {
  /// The title text to display.
  final String title;

  /// Creates an [AuthTitleWidget] with the given title.
  const AuthTitleWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}