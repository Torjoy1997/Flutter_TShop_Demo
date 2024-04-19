import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../model/order_model.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key, required this.order});

  final List<OrderModel> order;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: order.length,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, index) =>
          const SizedBox(height: AppDefineSizes.spaceBtwItems),
      itemBuilder: (_, index) {
        return BoxContainer(
          showBorder: true,
          padding: const EdgeInsets.all(AppDefineSizes.sm),
          radius: 15,
          backGroundColor: AppHelperFunctions.isDarkMode(context)
              ? AppDefineColors.dark
              : AppDefineColors.light,
          child: Column(
            children: [
              /// -- Row 1
              Row(
                children: [
                  /// 1 - Icon
                  const Icon(Iconsax.ship),
                  const SizedBox(width: AppDefineSizes.spaceBtwItems / 2),

                  /// 2 - Status & Date
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order[index].orderStatusText,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: AppDefineColors.primary,
                              fontWeightDelta: 1),
                        ),
                        Text(order[index].formattedOrderDate,
                            style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                  ),

                  /// 3 - Icon
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.arrow_right_34,
                          size: AppDefineSizes.iconSm)),
                ],
              ),
              const SizedBox(height: AppDefineSizes.spaceBtwItems),

              /// -- Bottom Row
              Row(
                children: [
                  /// Order No
                  Expanded(
                    child: Row(
                      children: [
                        /// 1 - Icon
                        const Icon(Iconsax.tag),
                        const SizedBox(width: AppDefineSizes.spaceBtwItems / 2),

                        /// Order
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                order[index].id,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Delivery Date
                  Expanded(
                    child: Row(
                      children: [
                        /// 1 - Icon
                        const Icon(Iconsax.calendar),
                        const SizedBox(width: AppDefineSizes.spaceBtwItems / 2),

                        /// Status & Date
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Date',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                order[index].formattedDeliveryDate,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
