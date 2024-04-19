import 'package:ecommerce_demo/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../../../core/layout/icon_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../bloc/product_bloc.dart';

class ProductBottomAction extends StatefulWidget {
  const ProductBottomAction({super.key, required this.productId});

  final String productId;

  @override
  State<ProductBottomAction> createState() => _ProductBottomActionState();
}

class _ProductBottomActionState extends State<ProductBottomAction> {
  int quantity = 0;
  Map<String, dynamic> variations = {};

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is SetVariationValueState) {
          if (state.variations.isNotEmpty) {
            variations = state.variations;
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDefineSizes.defaultSpace,
            vertical: AppDefineSizes.defaultSpace / 2),
        decoration: BoxDecoration(
            color: dark ? AppDefineColors.darkGrey : AppDefineColors.light,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppDefineSizes.cardRadiusLg),
                topRight: Radius.circular(AppDefineSizes.cardRadiusLg))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                IconContainer(
                  iconData: Iconsax.minus,
                  onPressed: () {
                    if (quantity > 0) {
                      setState(() {
                        quantity = quantity - 1;
                      });
                    }
                  },
                  backgroundColor: AppDefineColors.darkGrey,
                  width: 40,
                  height: 40,
                  iconColor: AppDefineColors.white,
                ),
                const SizedBox(
                  height: AppDefineSizes.spaceBtwItems,
                ),
                Text(
                  '$quantity',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: AppDefineSizes.spaceBtwItems,
                ),
                IconContainer(
                  iconData: Iconsax.add,
                  onPressed: () {
                    setState(() {
                      quantity = quantity + 1;
                    });
                  },
                  backgroundColor: AppDefineColors.black,
                  width: 40,
                  height: 40,
                  iconColor: AppDefineColors.white,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (variations.isNotEmpty && variations['stock'] != null) {
                  final int stock = int.parse(variations['stock'].toString());
                  if (stock < quantity) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: MessageBar.infoSnackBar(
                          title: 'Oh! Snap',
                          message: 'Your Quantity exceeds our stock'),
                      backgroundColor: Colors.transparent,
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                    ));
                  } else {
                    context.read<CartBloc>().add(CartItemAddEvent(
                          cartItem: {
                            'productId': widget.productId,
                            'Quantity': quantity,
                            'variations': variations
                          },
                        ));
                  }
                } else {
                  context.read<CartBloc>().add(CartItemAddEvent(
                        cartItem: {
                          'productId': widget.productId,
                          'Quantity': quantity,
                          'variations': variations
                        },
                      ));
                }
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(AppDefineSizes.md),
                  backgroundColor: AppDefineColors.black,
                  side: const BorderSide(color: AppDefineColors.black)),
              child: const Text('Add to Cart'),
            )
          ],
        ),
      ),
    );
  }
}
