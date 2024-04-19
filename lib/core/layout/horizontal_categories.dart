import 'package:ecommerce_demo/core/layout/section_headline_layout.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';



class HorizontalCategoryLayout extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext,int)  itemBuilder ;
  final int itemCount;
  const HorizontalCategoryLayout({
    super.key, required this.title,required this.itemCount, required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDefineSizes.defaultSpace),
      child: Column(
        children: [
           SectionHeading(
            title: title,
            showActionButton: false,
            textColor: AppDefineColors.white,
          ),
          const SizedBox(
            height: AppDefineSizes.spaceBtwItems,
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                itemCount: itemCount,
                scrollDirection: Axis.horizontal,
                itemBuilder: itemBuilder
            ),
          )
        ],
      ),
    );
  }
}