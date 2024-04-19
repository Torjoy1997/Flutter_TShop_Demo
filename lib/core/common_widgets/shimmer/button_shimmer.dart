import 'package:ecommerce_demo/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

class ButtonShimmer extends StatelessWidget {
  const ButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child:  AppShimmerEffect(width: 300, height: 30),
    );
  }
}