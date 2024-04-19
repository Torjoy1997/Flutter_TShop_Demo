import 'package:ecommerce_demo/utils/constants/image_strings.dart';
import 'package:ecommerce_demo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../core/layout/horizontal_categories.dart';
import '../../../../utils/constants/colors.dart';

class HorizontalViewOfItem extends StatelessWidget {
  const HorizontalViewOfItem({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalCategoryLayout(
        title: 'Products Categories',
        itemCount: AppImages.categoryIcon.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              /*Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const SubCategoriesScreen()));*/
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(right: AppDefineSizes.spaceBtwItems),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    padding: const EdgeInsets.all(AppDefineSizes.sm),
                    decoration: BoxDecoration(
                        color: AppDefineColors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Image(
                          image: AssetImage(
                              AppImages.categoryIcon.values.toList()[index])),
                    ),
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems / 2,
                  ),
                  SizedBox(
                      width: 55,
                      child: Text(
                        AppImages.categoryIcon.keys.toList()[index],
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: AppDefineColors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          );
        });
  }
}
