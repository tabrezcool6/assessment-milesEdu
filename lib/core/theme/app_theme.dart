import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Extracted ThemeData settings for the app.
/// Call with: AppTheme.themeData(context)
class AppTheme {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      textTheme: GoogleFonts.varelaTextTheme(Theme.of(context).textTheme),
      dialogTheme: const DialogTheme(backgroundColor: Colors.white),
      appBarTheme: AppBarTheme(
        titleSpacing: 0,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.cyan.shade500,
        titleTextStyle: GoogleFonts.varela(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}
