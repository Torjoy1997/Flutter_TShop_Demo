import 'package:ecommerce_demo/core/layout/rounded_image_layout.dart';
import 'package:ecommerce_demo/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_demo/features/store/model/brand.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../product/ui/widgets/product_detail/product_price_tag.dart';
import '../../../product/ui/widgets/product_detail/product_title_text.dart';
import '../../../store/ui/widgets/brand/brand_headline_section.dart';

class CartMenuItem extends StatelessWidget {
  const CartMenuItem({
    super.key,
    required this.image,
    required this.quantity,
    this.variations = const {},
    required this.cartId,
    required this.title,
    required this.brandData,
    required this.price,
  });
  final String cartId;
  final String image;
  final int quantity;
  final String title;
  final BrandModel brandData;
  final Map<String, dynamic> variations;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        RoundedImageLayout(
          imageUrl: image,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(AppDefineSizes.sm),
          backGroundColor: AppHelperFunctions.isDarkMode(context)
              ? AppDefineColors.darkGrey
              : AppDefineColors.light,
          isNetworkImage: true,
        ),
        const SizedBox(
          width: AppDefineSizes.spaceBtwItems,
        ),
        Flexible(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandHeadlineWithIcon(title: brandData.name),
              ProductTitleText(
                title: title,
                maxLines: 1,
              ),
              if (variations.isNotEmpty)
                for (var cartVariation in variations.entries)
                  if (cartVariation.key != 'image' &&
                      cartVariation.key != 'price' &&
                      cartVariation.key != 'stock') ...[
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '${cartVariation.key} ',
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: '${cartVariation.value}',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ])),
                    const SizedBox(
                      width: AppDefineSizes.spaceBtwItems / 2,
                    )
                  ],
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Quantity : $quantity',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<CartBloc>()
                          .add(CartItemRemoveEvent(cartId: cartId));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.trash,
                          color: AppDefineColors.primary,
                          size: AppDefineSizes.iconSm,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Remove',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: AppDefineColors.primary),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        ProductPriceTag(price: '$price')
      ],
    );
  }
}
