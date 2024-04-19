import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../../layout/box_container_layout.dart';
import 'shimmer_effect.dart';

class AddressShimmer extends StatelessWidget {
  const AddressShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BoxContainer(
      width: double.infinity,
      backGroundColor: Colors.transparent,
      showBorder: true,
      margin: EdgeInsets.only(bottom: AppDefineSizes.spaceBtwItems),
      padding: EdgeInsets.all(8),
      radius: 15,
      child: Column(
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
    );
  }
}
