import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../layout/rounded_image_layout.dart';

class HorizontalCardView extends StatelessWidget {
  const HorizontalCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool darkMode = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        /*Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const ProductDetailScreen()));*/
      },
      child: SizedBox(
        width: 350,
        height: 150,
        child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: darkMode ? AppDefineColors.dark : Colors.grey.shade200,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    BoxContainer(
                      height: 120,
                      width: 130,
                      padding: const EdgeInsets.all(AppDefineSizes.sm),
                      radius: 15,
                      backGroundColor: darkMode ? AppDefineColors.dark : AppDefineColors.light,
                      child: Stack(
                        children: [
                          const RoundedImageLayout(
                            imageUrl: AppImages.productImage1,
                            applyImageRadius: true,
                            height: 120,
                          ),
                          Positioned(
                            top: 0,
                            left: 5,
                            child: BoxContainer(
                              width: 40,
                              height: 25,
                              radius: AppDefineSizes.sm,
                              backGroundColor:
                              AppDefineColors.secondary.withOpacity(0.8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppDefineSizes.sm, vertical: AppDefineSizes.xs),
                              child: Text(
                                '25%',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .apply(color: AppDefineColors.black),
                              ),
                            ),
                          ),
                          Positioned(
                              top: -10,
                              right: -10,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Iconsax.heart),
                              )),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: AppDefineSizes.sm, left: AppDefineSizes.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           /* ProductTitleText(
                              title: 'Green Nike Half Sleeves',
                            ),
                            TitleBrandWithIcon(title: 'Nike'),
                            SizedBox(
                              height: AppDefineSizes.spaceBtwItems / 2,
                            ),
                            ProductPriceText(
                              price: '256.0',
                            )*/
                          ],
                        ),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}