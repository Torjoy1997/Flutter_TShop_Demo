import 'package:ecommerce_demo/features/store/model/brand.dart';
import 'package:ecommerce_demo/features/store/ui/widgets/brand/brand_headline_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/layout/box_container_layout.dart';
import '../../../../../utils/constants/sizes.dart';

class BrandContainer extends StatelessWidget {
  const BrandContainer({
    super.key,
    required this.nameTitle,
    required this.imageUrl,
    this.productCount,
  });

  final String nameTitle;
  final String imageUrl;
  final int? productCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/store/brands/$nameTitle',
            extra: BrandModel(
                image: imageUrl, name: nameTitle, productsCount: productCount));
      },
      child: BoxContainer(
        backGroundColor: Colors.transparent,
        showBorder: true,
        padding: const EdgeInsets.all(AppDefineSizes.sm),
        radius: 15,
        child: BrandHeadline(
          title: nameTitle,
          imageUrl: imageUrl,
          subTitle: '${productCount.toString()} products',
        ),
      ),
    );
  }
}
