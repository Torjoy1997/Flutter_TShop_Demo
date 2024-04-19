import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/core/layout/rounded_image_layout.dart';
import 'package:ecommerce_demo/features/store/model/brand.dart';
import 'package:ecommerce_demo/features/store/ui/widgets/brand/brand_headline_section.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class BrandView extends StatelessWidget {
  const BrandView({super.key, required this.imageUrls, required this.brand});

  final List<String> imageUrls;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      showBorder: true,
      backGroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: AppDefineSizes.spaceBtwItems),
      padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
      radius: 15,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        BrandHeadline(
          title: brand.name,
          imageUrl: brand.image,
          subTitle: '${brand.productsCount} products',
        ),
        Row(
          children: imageUrls
              .take(3)
              .map((imageUrl) => brandTopProductImageWidget(imageUrl, context))
              .toList(),
        )
      ]),
    );
  }
}

Widget brandTopProductImageWidget(String imageUrl, BuildContext context) {
  return Expanded(
      child: BoxContainer(
    height: 100,
    width: 100,
    radius: 20,
    padding: const EdgeInsets.all(AppDefineSizes.md),
    margin: const EdgeInsets.only(right: AppDefineSizes.sm),
    backGroundColor: AppHelperFunctions.isDarkMode(context)
        ? AppDefineColors.darkGrey
        : AppDefineColors.light,
    child: RoundedImageLayout(
      imageUrl: imageUrl,
      isNetworkImage: true,
    ),
  ));
}
