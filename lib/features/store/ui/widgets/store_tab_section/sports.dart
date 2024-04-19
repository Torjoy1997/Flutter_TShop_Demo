import 'package:ecommerce_demo/features/store/model/category.dart';
import 'package:ecommerce_demo/features/store/ui/widgets/brand/brand_view.dart';
import 'package:ecommerce_demo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common_widgets/card/vertical_card.dart';
import '../../../../../core/layout/grid_layout.dart';
import '../../../../../core/layout/section_headline_layout.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../model/brand.dart';

class SportsTabView extends StatelessWidget {
  const SportsTabView(
      {super.key, required this.categoryData, required this.brands});

  final CategoryModel categoryData;
  final List<BrandModel> brands;

  @override
  Widget build(BuildContext context) {
    if (categoryData.brandedProduct.isEmpty) {
      return Center(
        child: Text(
          'No Data For this Brand',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .apply(color: AppDefineColors.grey),
        ),
      );
    }
    return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              ...categoryData.brandedProduct.entries
                  .map((e) => BrandView(
                        imageUrls: e.value,
                        brand: brands
                            .where((element) => element.name == e.key)
                            .first,
                      ))
                  .toList(),
              const SizedBox(
                height: AppDefineSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'You might like',
                showActionButton: false,
              ),
              GridLayout(
                  itemCount: categoryData.categoryProduct.length,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => VerticalCardView(
                        productData: categoryData.categoryProduct[index],
                      )),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
            ],
          ),
        ]);
  }
}
