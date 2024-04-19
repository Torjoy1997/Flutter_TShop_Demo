
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CustomTextFormFieldTheme {
  CustomTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppDefineColors.darkGrey,
    suffixIconColor: AppDefineColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: AppDefineSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: AppDefineSizes.fontSizeMd, color: AppDefineColors.black),
    hintStyle: const TextStyle().copyWith(fontSize: AppDefineSizes.fonAppDefineSizesm, color: AppDefineColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: AppDefineColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppDefineColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppDefineColors.grey),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppDefineColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppDefineColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AppDefineColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: AppDefineColors.darkGrey,
    suffixIconColor: AppDefineColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: AppDefineSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: AppDefineSizes.fontSizeMd, color: AppDefineColors.white),
    hintStyle: const TextStyle().copyWith(fontSize: AppDefineSizes.fonAppDefineSizesm, color: AppDefineColors.white),
    floatingLabelStyle: const TextStyle().copyWith(color: AppDefineColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppDefineColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppDefineColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppDefineColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppDefineColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppDefineSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AppDefineColors.warning),
    ),
  );
}
