import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/layout/section_headline_layout.dart';
import '../../../../utils/constants/sizes.dart';

import '../../../Address/bloc/address_bloc.dart';
import '../../../Address/model/address.dart';
import '../../../Address/ui/widgets/address_container.dart';

class BillAddressSection extends StatelessWidget {
  const BillAddressSection({super.key, required this.userAddress});

  final List<AddressModel> userAddress;

  void openBillingAddress(BuildContext context) {
    debugPrint(userAddress.length.toString());
    showBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(AppDefineSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading(
                      title: 'Select Address', showActionButton: false),
                  Expanded(
                    child: Padding(
                        padding:
                            const EdgeInsets.all(AppDefineSizes.defaultSpace),
                        child: ListView.builder(
                            itemCount: userAddress.length,
                            itemBuilder: (_, index) {
                              return ContainerOfAddress(
                                userAddress: userAddress[index],
                                onTap: () {
                                  context.read<AddressBloc>().add(
                                      SelectTheUserAddressEvet(
                                          userAddressId:
                                              userAddress[index].id));
                                  context.pop();
                                },
                              );
                            })),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {
            openBillingAddress(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            userAddress.first.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const Icon(
                Icons.phone,
                color: Colors.grey,
                size: 16,
              ),
              const SizedBox(
                width: AppDefineSizes.spaceBtwItems,
              ),
              Text(
                userAddress.first.formattedPhoneNo,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems / 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const Icon(
                Icons.location_history,
                color: Colors.grey,
                size: 16,
              ),
              const SizedBox(
                width: AppDefineSizes.spaceBtwItems,
              ),
              Expanded(
                child: Text(
                  '${userAddress.first.street},${userAddress.first.postalCode}, ${userAddress.first.state},${userAddress.first.country}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
