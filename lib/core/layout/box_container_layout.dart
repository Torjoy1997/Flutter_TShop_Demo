import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer(
      {super.key,
      this.backGroundColor = AppDefineColors.textWhite,
      this.height,
      this.width,
      this.padding = EdgeInsets.zero,
      this.radius,
      this.child,
      this.margin = EdgeInsets.zero,
      this.showBorder = false,
      this.alignment});

  final double? width;
  final double? height;
  final EdgeInsets padding;
  final double? radius;
  final Color backGroundColor;
  final Widget? child;
  final EdgeInsets margin;
  final bool showBorder;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
          borderRadius: radius == null
              ? BorderRadius.zero
              : BorderRadius.circular(radius!),
          color: backGroundColor,
          border: showBorder ? Border.all(color: AppDefineColors.grey) : null),
      child: child,
    );
  }
}
