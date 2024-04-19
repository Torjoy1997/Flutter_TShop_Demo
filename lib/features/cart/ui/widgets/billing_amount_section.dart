import 'package:ecommerce_demo/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BillPriceTitle(title: 'SubTotal: ', priceTag: '€ $totalPrice'),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),
        const BillPriceTitle(title: 'Shipping Fee: ', priceTag: '€ 6.0'),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),
        BillPriceTitle(
            title: 'Tax Fee: ',
            priceTag:
                '€ ${TPricingCalculator.calculateTax(totalPrice, 'germany')}'),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),
        BillPriceTitle(
          title: 'Order Total: ',
          priceTag:
              '${totalPrice + 6.0 + double.parse(TPricingCalculator.calculateTax(totalPrice, 'germany'))}',
          isTextLarge: true,
        ),
      ],
    );
  }
}

class BillPriceTitle extends StatelessWidget {
  const BillPriceTitle({
    super.key,
    required this.title,
    required this.priceTag,
    this.isTextLarge = false,
  });

  final String title, priceTag;
  final bool isTextLarge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          priceTag,
          style: isTextLarge
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
