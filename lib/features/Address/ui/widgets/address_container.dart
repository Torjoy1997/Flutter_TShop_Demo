import 'package:ecommerce_demo/features/Address/bloc/address_bloc.dart';
import 'package:ecommerce_demo/features/Address/model/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/layout/box_container_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ContainerOfAddress extends StatelessWidget {
  const ContainerOfAddress({
    super.key,
    required this.userAddress,
    required this.onTap,
  });

  final AddressModel userAddress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return BoxContainer(
      width: double.infinity,
      showBorder: true,
      backGroundColor: userAddress.seclectedAddress
          ? AppDefineColors.primary.withOpacity(0.5)
          : Colors.transparent,
      margin: const EdgeInsets.only(bottom: AppDefineSizes.spaceBtwItems),
      padding: const EdgeInsets.all(8),
      radius: 15,
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              userAddress.seclectedAddress ? Iconsax.tick_circle : null,
              color: userAddress.seclectedAddress
                  ? dark
                      ? AppDefineColors.light
                      : AppDefineColors.dark
                  : null,
            ),
          ),
          Positioned(
            right: 5,
            bottom: 0,
            child: InkWell(
              onTap: () {
                context
                    .read<AddressBloc>()
                    .add(RemoveUserAddressEvent(userAddressId: userAddress.id));
              },
              child: Icon(
                userAddress.seclectedAddress ? null : Iconsax.trash,
                color: userAddress.seclectedAddress
                    ? dark
                        ? AppDefineColors.light
                        : AppDefineColors.dark
                    : null,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userAddress.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppDefineSizes.sm / 2,
                ),
                Text(
                  userAddress.phoneNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: AppDefineSizes.sm / 2,
                ),
                Text(
                  '${userAddress.street}, ${userAddress.city}, ${userAddress.country}',
                  softWrap: true,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
