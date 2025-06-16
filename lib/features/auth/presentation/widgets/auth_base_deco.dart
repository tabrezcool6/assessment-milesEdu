import 'dart:ui';

import 'package:flutter/material.dart';

/// A reusable widget that provides a visually appealing background and glassmorphic effect
/// for authentication-related pages.
///
/// This widget wraps its [child] with a gradient background, SafeArea, and a glass-like
/// blurred container with rounded corners. It is intended to be used as the base decoration
/// for sign-in, sign-up, and reset password pages.
class AuthBaseDecorationClass extends StatelessWidget {
  /// The widget to display inside the decorated container.
  final Widget child;

  /// Creates an [AuthBaseDecorationClass] with the given [child].
  const AuthBaseDecorationClass({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Solid background color for the SafeArea.
      color: Colors.cyan.shade500,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              // Background gradient covering the entire screen.
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.cyan.shade500, Colors.indigo.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Centered glassmorphic effect container for the form.
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      // The actual authentication form or content.
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
