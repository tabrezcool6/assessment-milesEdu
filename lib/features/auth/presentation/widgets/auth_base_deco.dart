import 'dart:ui';

import 'package:flutter/material.dart';

class AuthBaseDecorationClass extends StatelessWidget {
  const AuthBaseDecorationClass({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan.shade500, // Background color for SafeArea
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              // Background Gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.cyan.shade500, Colors.indigo.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Glassmorphic Effect
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
