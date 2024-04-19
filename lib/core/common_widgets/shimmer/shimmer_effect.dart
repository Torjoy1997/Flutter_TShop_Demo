import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/utils/constants/colors.dart';
import 'package:ecommerce_demo/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerEffect extends StatelessWidget {
  const AppShimmerEffect(
      {super.key,
      required this.height,
      required this.width,
      this.radius = 15,
      this.color});

  final double height, width, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
        baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
        child: BoxContainer(
          width: width,
          height: height,
          backGroundColor: color ??
              (dark ? AppDefineColors.darkerGrey : AppDefineColors.white),
          radius: radius,
        ));
  }
}
