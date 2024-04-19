import 'package:ecommerce_demo/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:ecommerce_demo/core/layout/grid_layout.dart';
import 'package:flutter/material.dart';

class BrandShimmer extends StatelessWidget {
  const BrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const AppShimmerEffect(height: 300, width: 80));
  }
}
