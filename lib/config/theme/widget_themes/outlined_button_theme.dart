
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';



/* -- Light & Dark Outlined Button Themes -- */
class CustomOutlinedButtonTheme {
  CustomOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppDefineColors.dark,
      side: const BorderSide(color: AppDefineColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: AppDefineColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: AppDefineSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDefineSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppDefineColors.light,
      side: const BorderSide(color: AppDefineColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: AppDefineColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: AppDefineSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDefineSizes.buttonRadius)),
    ),
  );
}
