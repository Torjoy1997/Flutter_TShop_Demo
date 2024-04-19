
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';


class AppChipTheme {
  AppChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: AppDefineColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: AppDefineColors.black),
    selectedColor: AppDefineColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: AppDefineColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: AppDefineColors.darkerGrey,
    labelStyle: TextStyle(color: AppDefineColors.white),
    selectedColor: AppDefineColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: AppDefineColors.white,
  );
}
