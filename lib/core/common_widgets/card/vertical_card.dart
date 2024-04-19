import 'package:ecommerce_demo/core/common_widgets/favorite_icon.dart';
import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/core/layout/rounded_image_layout.dart';
import 'package:ecommerce_demo/features/product/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:iconsax/iconsax.dart';

import '../../../features/product/repos/product.dart';
import '../../../features/product/ui/widgets/product_detail/product_price_tag.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class VerticalCardView extends StatelessWidget {
  const VerticalCardView({super.key, required this.productData});

  final ProductModel productData;





  @override
  Widget build(BuildContext context) {
    final bool darkMode = AppHelperFunctions.isDarkMode(context);
    final product = productData;
    final router = GoRouter.of(context).routerDelegate.currentConfiguration;
    String discount = context.read<ProductRepository>().calculateSalePercentage(
        productData.price, productData.salePrice) ??
        '';
    String getProductPrice =
        context.read<ProductRepository>().getProductPrice(productData);

    return GestureDetector(
      onTap: () {
        context.push('/product-detail/${product.id}');
      },
      child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: darkMode ? AppDefineColors.dark : AppDefineColors.white,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    RoundedImageLayout(
                      width: 170,
                      height: 165,
                      imageUrl: product.thumbnail,
                      isNetworkImage: true,
                    ),
                    if (discount.isNotEmpty)
                      Positioned(
                        top: 12,
                        left: 10,
                        child: BoxContainer(
                          width: 40,
                          height: 25,
                          radius: AppDefineSizes.sm,
                          backGroundColor:
                              AppDefineColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDefineSizes.sm,
                              vertical: AppDefineSizes.xs),
                          child: Text(
                            '$discount%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: AppDefineColors.black),
                          ),
                        ),
                      ),
                    if (router.fullPath != '/wish_list')
                      Positioned(
                          top: 0,
                          right: 0,
                          child:
                              FavouriteIcon(productId: product.id)),
                  ],
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: Theme.of(context).textTheme.labelLarge!.apply(color: AppDefineColors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: AppDefineSizes.spaceBtwItems / 2,
                          ),
                          Row(
                            children: [
                              Text(
                                product.brand!.name,
                                style: Theme.of(context).textTheme.labelMedium!.apply(color: AppDefineColors.black),
                                maxLines: 1,
                              ),
                              const SizedBox(
                                width: AppDefineSizes.xs,
                              ),
                              const Icon(
                                Iconsax.verify5,
                                color: AppDefineColors.primary,
                                size: AppDefineSizes.iconXs,
                              )
                            ],
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                if (product.productType ==
                                        ProductType.single.toString() &&
                                    product.salePrice > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppDefineSizes.sm),
                                    child: Text(
                                      product.price.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: AppDefineColors.black,
                                              color: AppDefineColors.black),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: AppDefineSizes.sm),
                                  child: ProductPriceTag(
                                    price: getProductPrice,
                                    isForCard: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
