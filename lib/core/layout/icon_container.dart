
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';





class IconContainer extends StatelessWidget {
  const IconContainer(
      {super.key,
      this.width,
      this.height,
      this.size = AppDefineSizes.lg,
      required this.iconData,
      this.iconColor,
      this.backgroundColor,
      this.onPressed});

  final double? width, height, size;
  final IconData iconData;
  final Color? iconColor, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor ??
              (AppHelperFunctions.isDarkMode(context)
                  ? AppDefineColors.black.withOpacity(0.9)
                  : AppDefineColors.white.withOpacity(0.9)),
          borderRadius: BorderRadius.circular(100)),
      child: IconButton(
        icon: Icon(
          iconData,
          color: iconColor,
          size: size,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
