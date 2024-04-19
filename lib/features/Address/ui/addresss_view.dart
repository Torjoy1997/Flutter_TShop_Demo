import 'package:ecommerce_demo/core/common_widgets/shimmer/address_shimmer.dart';
import 'package:ecommerce_demo/features/Address/bloc/address_bloc.dart';
import 'package:ecommerce_demo/features/Address/model/address.dart';
import 'package:ecommerce_demo/features/Address/ui/widgets/address_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../core/layout/custom_bar/appbar.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<AddressModel> userAddress = [];

  @override
  void initState() {
    context.read<AddressBloc>().add(const FetchUserAddressEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed('Add_Address');
          },
          backgroundColor: AppDefineColors.primary,
          child: const Icon(
            Iconsax.add,
            color: AppDefineColors.white,
          )),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is FetchUserAddressLoaded) {
            userAddress = state.userAddress;
            userAddress.sort((a, b) {
              if (b.seclectedAddress) {
                return 1;
              }
              return -1;
            });
          }
          if (state is SelectTheUserAddress) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: MessageBar.successSnackBar(
                  title: 'Default Adsress',
                  message: 'Change your default Address SuccessFully'),
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
            ));
          }
        },
        builder: (context, state) {
          if (state is FetchUserAddressLoading && userAddress.isEmpty) {
            return Padding(
                padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (_, index) {
                      return const AddressShimmer();
                    }));
          }
          return Padding(
              padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
              child: ListView.builder(
                  itemCount: userAddress.length,
                  itemBuilder: (_, index) {
                    return ContainerOfAddress(
                      userAddress: userAddress[index],
                      onTap: () {
                        context.read<AddressBloc>().add(
                            SelectTheUserAddressEvet(
                                userAddressId: userAddress[index].id));
                      },
                    );
                  }));
        },
      ),
    );
  }
}
