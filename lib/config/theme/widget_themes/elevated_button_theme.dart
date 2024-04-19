
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';


/* -- Light & Dark Elevated Button Themes -- */
class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppDefineColors.light,
      backgroundColor: AppDefineColors.primary,
      disabledForegroundColor: AppDefineColors.darkGrey,
      disabledBackgroundColor: AppDefineColors.buttonDisabled,
      side: const BorderSide(color: AppDefineColors.primary),
      padding: const EdgeInsets.symmetric(vertical: AppDefineSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: AppDefineColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDefineSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppDefineColors.light,
      backgroundColor: AppDefineColors.primary,
      disabledForegroundColor: AppDefineColors.darkGrey,
      disabledBackgroundColor: AppDefineColors.darkerGrey,
      side: const BorderSide(color: AppDefineColors.primary),
      padding: const EdgeInsets.symmetric(vertical: AppDefineSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: AppDefineColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDefineSizes.buttonRadius)),
    ),
  );
}
