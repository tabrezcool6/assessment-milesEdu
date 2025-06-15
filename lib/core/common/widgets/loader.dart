import 'package:flutter/material.dart';
import 'package:assessment_miles_edu/core/theme/app_pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.indigo.shade400,
        padding: EdgeInsets.all(6),
      ),
    );
  }
}
