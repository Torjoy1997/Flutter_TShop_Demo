import 'package:ecommerce_demo/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class BrandWithProductShimmer extends StatelessWidget {
  const BrandWithProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BoxContainer(
      showBorder: true,
      width: 300,
      height: 200,
      backGroundColor: Colors.transparent,
      margin: EdgeInsets.only(bottom: AppDefineSizes.spaceBtwItems),
      padding: EdgeInsets.all(AppDefineSizes.defaultSpace),
      radius: 15,
      child: Column(
        children: [
          Row(
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
          SizedBox(
            height: AppDefineSizes.spaceBtwItems / 2,
          ),
          Row(
            children: [
              AppShimmerEffect(height: 60, width: 60),
              SizedBox(
                width: AppDefineSizes.spaceBtwItems,
              ),
              AppShimmerEffect(height: 60, width: 60),
              SizedBox(
                width: AppDefineSizes.spaceBtwItems,
              ),
              AppShimmerEffect(height: 60, width: 60),
              SizedBox(
                width: AppDefineSizes.spaceBtwItems,
              ),
            ],
          )
        ],
      ),
    );
  }
}
