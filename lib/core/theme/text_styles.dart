import 'package:flutter/material.dart';
import 'package:assessment_miles_edu/core/theme/app_pallete.dart';

/// A utility class for defining reusable text styles.
class TextStyles {
  /// Customizable text style: Default Size 10, Color White, Regular, Weight 400
  static customSizeColorTextStyle({double? fontSize, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 10.0,
      color: color ?? AppPallete.whiteColor,
      fontWeight: FontWeight.w400,
    );
  }

  /// Customizable text style: Default Size 10, Color White, Regular, Weight 400
  static customRegular400Text(String text, {double? textSize, Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize ?? 10.0,
        color: color ?? AppPallete.whiteColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
