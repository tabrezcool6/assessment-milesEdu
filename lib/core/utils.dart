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

  ///
  ///
  /// Dual Button Alert Dialog Box
  static singleBtnPopAlertDialogBox({
    required BuildContext context,
    required String title,
    required String desc,
    required Function() onTap1,
  }) {
    // set up the button
    Widget okButton = TextButton(
      onPressed: onTap1,
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: Text('OK', style: TextStyle(color: AppPallete.primaryColor)),
    );
    // set up the button
    Widget reportButton = TextButton(
      onPressed: () => Navigator.pop(context),
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: const Text('Cancel', style: TextStyle(color: Colors.red)),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      // content: Text(desc),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      actions: [reportButton, okButton],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () => Future.value(false), child: alert);
      },
    );
  }

  ///
}
