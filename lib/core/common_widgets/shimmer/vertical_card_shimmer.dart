import 'package:ecommerce_demo/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:ecommerce_demo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class VerticalCardShimmer extends StatelessWidget {
  const VerticalCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image
          AppShimmerEffect(height: 180, width: 180),
          SizedBox(
            height: AppDefineSizes.spaceBtwItems,
          ),
          //Text
          AppShimmerEffect(width: 160, height: 15),
          SizedBox(
            height: AppDefineSizes.spaceBtwItems / 2,
          ),
          AppShimmerEffect(width: 110, height: 15)
        ],
      ),
    );
  }
}
