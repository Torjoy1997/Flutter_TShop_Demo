import 'package:ecommerce_demo/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:ecommerce_demo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        height: 100,
        child: Row(
          children: [
            AppShimmerEffect(height: 60, width: 60),
            SizedBox(
              width: AppDefineSizes.spaceBtwItems,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Text
                AppShimmerEffect(width: 160, height: 15),
                SizedBox(
                  height: AppDefineSizes.spaceBtwItems / 2,
                ),
                AppShimmerEffect(width: 110, height: 15)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
