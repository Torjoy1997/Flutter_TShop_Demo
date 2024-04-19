import 'package:ecommerce_demo/features/cart/ui/widgets/payment_title.dart';
import 'package:flutter/material.dart';

import '../../../../core/layout/box_container_layout.dart';
import '../../../../core/layout/section_headline_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../model/payment_model.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key, required this.paymentData});

  final PaymentMethodModel paymentData;

  void openPaymentSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppDefineSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                  title: 'Select Payment Method', showActionButton: false),
              const SizedBox(height: AppDefineSizes.spaceBtwSections),
              PaymentTitle(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: AppImages.paypal)),
              const SizedBox(height: AppDefineSizes.spaceBtwItems / 2),
              PaymentTitle(
                  paymentMethod: PaymentMethodModel(
                      name: 'Google Pay', image: AppImages.googlePay)),
              const SizedBox(height: AppDefineSizes.spaceBtwItems / 2),
              PaymentTitle(
                  paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay', image: AppImages.applePay)),
              const SizedBox(height: AppDefineSizes.spaceBtwItems / 2),
              PaymentTitle(
                  paymentMethod:
                      PaymentMethodModel(name: 'VISA', image: AppImages.visa)),
              const SizedBox(height: AppDefineSizes.spaceBtwItems / 2),
              PaymentTitle(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card', image: AppImages.masterCard)),
              const SizedBox(height: AppDefineSizes.spaceBtwItems / 2),
              PaymentTitle(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paytm', image: AppImages.paytm)),
              const SizedBox(height: AppDefineSizes.spaceBtwItems / 2),
              PaymentTitle(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paystack', image: AppImages.paystack)),
              const SizedBox(height: AppDefineSizes.spaceBtwItems / 2),
              PaymentTitle(
                  paymentMethod: PaymentMethodModel(
                      name: 'Credit Card', image: AppImages.creditCard)),
              const SizedBox(height: AppDefineSizes.spaceBtwItems / 2),
              const SizedBox(height: AppDefineSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        SectionHeading(
          title: 'Payment Method',
          buttonTitle: 'change',
          onPressed: () {
            openPaymentSheet(context);
          },
        ),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            BoxContainer(
              width: 60,
              height: 35,
              backGroundColor:
                  dark ? AppDefineColors.light : AppDefineColors.white,
              padding: const EdgeInsets.all(AppDefineSizes.sm),
              child: Image(
                image: AssetImage(paymentData.image),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: AppDefineSizes.spaceBtwItems / 2,
            ),
            Text(
              paymentData.name,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        )
      ],
    );
  }
}
