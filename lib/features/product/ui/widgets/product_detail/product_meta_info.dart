import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/features/product/ui/widgets/product_detail/product_price_tag.dart';
import 'package:ecommerce_demo/features/product/ui/widgets/product_detail/product_title_text.dart';
import 'package:ecommerce_demo/features/store/model/brand.dart';
import 'package:ecommerce_demo/features/store/ui/widgets/brand/brand_headline_section.dart';

import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData(
      {super.key,
      required this.productTitle,
      this.discount,
      this.salePrice = '',
      required this.price,
      required this.brand,
      required this.stock, required this.isVariation});

  final String productTitle;
  final String? discount;
  final String salePrice, price;
  final BrandModel brand;
  final int stock;
  final bool isVariation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (discount != null)
              BoxContainer(
                radius: AppDefineSizes.sm,
                backGroundColor: AppDefineColors.secondary.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDefineSizes.sm, vertical: AppDefineSizes.xs),
                child: Text(
                  '$discount%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: AppDefineColors.black),
                ),
              ),
            const SizedBox(
              width: AppDefineSizes.spaceBtwItems,
            ),
            if (salePrice != price) ...[
              Text(price,
                  style: Theme.of(context).textTheme.titleSmall!.apply(
                        decoration: TextDecoration.lineThrough,
                      )),
              const SizedBox(
                width: AppDefineSizes.spaceBtwItems,
              ),
            ],
          ],
        ),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),

        isVariation ? ProductPriceTag(
          price: salePrice.isNotEmpty ? 'Price Range: $salePrice' : 'Price Range: $price',
          isLarge: true,
        ): ProductPriceTag(
          price: salePrice.isNotEmpty ? '$salePrice €' : '$price €',
          isLarge: true,
          ),


        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),
        ProductTitleText(title: productTitle),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const ProductTitleText(title: 'Status'),
            const SizedBox(
              width: AppDefineSizes.spaceBtwItems,
            ),
            if (stock > 0)
              Text(
                'In Stock ($stock)',
                style: Theme.of(context).textTheme.titleMedium,
              )
            else
              Text(
                'Out of Stock',
                style: Theme.of(context).textTheme.titleMedium,
              )
          ],
        ),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 1.5,
        ),
        BrandHeadline(
          title: brand.name,
          imageUrl: brand.image,
          applySmallImage: true,
        ),
      ],
    );
  }
}
