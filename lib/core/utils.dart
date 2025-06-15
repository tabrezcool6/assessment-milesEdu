import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
import 'package:assessment_miles_edu/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:assessment_miles_edu/core/theme/text_styles.dart';

class Utils {
  // Static method to show Snackbar
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          // backgroundColor: AppPallete.doveGrey600Color,
          content: Text(message),
        ),
      );
  }

  // Static method to show a loading dialog
  static void showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loader(),
                    const SizedBox(width: 16.0),
                    const Text('Loading...', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
