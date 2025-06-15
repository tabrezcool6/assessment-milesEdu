import 'package:flutter/material.dart';

class AuthInputFieldWidget extends StatefulWidget {
  const AuthInputFieldWidget({
    required this.label,
    required this.controller,
    this.isDone = false,
    this.obsecureText = false,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final bool isDone;
  final bool obsecureText;

  @override
  State<AuthInputFieldWidget> createState() => _AuthInputFieldWidgetState();
}

class _AuthInputFieldWidgetState extends State<AuthInputFieldWidget> {
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
          widget.isDone == true ? TextInputAction.done : TextInputAction.next,
      obscureText: _isObscured, // Use the state variable

      decoration: InputDecoration(
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

class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget({required this.title, super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

class AuthInputFieldWidget extends StatelessWidget {
  const AuthInputFieldWidget({
    required this.label,
    required this.controller,
    this.isDone = false,
    this.obsecureText = false,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final bool isDone;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction:
          isDone == true ? TextInputAction.done : TextInputAction.next,
      obscureText: obsecureText,

      decoration: InputDecoration(
        suffixIcon:
            label == 'Password'
                ? IconButton(
                  icon: Icon(Icons.visibility_outlined),
                  color: Colors.white,
                  onPressed: () {},
                )
                : null,

        labelText: label,
        // filled: true,
        // fillColor: Colors.white.withOpacity(0.25),
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
          return '$label cannot be empty';
        }
        return null;
      },
    );
  }
}

 */