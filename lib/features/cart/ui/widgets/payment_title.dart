import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/features/Address/bloc/address_bloc.dart';
import 'package:ecommerce_demo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../model/payment_model.dart';

class PaymentTitle extends StatelessWidget {
  const PaymentTitle({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        context
            .read<AddressBloc>()
            .add(ChangePaymentMethod(paymentMethod: paymentMethod));
        context.pop();
      },
      leading: BoxContainer(
        width: 60,
        height: 40,
        backGroundColor: AppHelperFunctions.isDarkMode(context)
            ? AppDefineColors.light
            : AppDefineColors.white,
        padding: const EdgeInsets.all(AppDefineSizes.sm),
        child:
            Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
