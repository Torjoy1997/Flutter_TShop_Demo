import 'package:ecommerce_demo/config/theme/widget_themes/appbar_theme.dart';
import 'package:ecommerce_demo/config/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:ecommerce_demo/config/theme/widget_themes/checkbox_theme.dart';
import 'package:ecommerce_demo/config/theme/widget_themes/chip_theme.dart';
import 'package:ecommerce_demo/config/theme/widget_themes/elevated_button_theme.dart';
import 'package:ecommerce_demo/config/theme/widget_themes/outlined_button_theme.dart';
import 'package:ecommerce_demo/config/theme/widget_themes/text_field_theme.dart';
import 'package:ecommerce_demo/config/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class TheAppTheme {
  TheAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppDefineColors.grey,
    brightness: Brightness.light,
    primaryColor: AppDefineColors.primary,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppDefineColors.white,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppDefineColors.grey,
    brightness: Brightness.dark,
    primaryColor: AppDefineColors.primary,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppDefineColors.black,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.darkInputDecorationTheme,
  );
}