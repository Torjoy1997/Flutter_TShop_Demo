import 'package:ecommerce_demo/features/Address/bloc/address_bloc.dart';
import 'package:ecommerce_demo/features/Address/repos/address.dart';
import 'package:ecommerce_demo/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final editController = context.read<AddressRepository>();
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddUserAddressState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MessageBar.successSnackBar(
                title: 'Add Address',
                message: 'Added your Address SuccessFully'),
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
          ));
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          showBackArrow: true,
          title: Text('Add New Address'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
            child: Form(
                key: editController.addressFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: editController.nameOfUser,
                      validator: (value) =>
                          FormValidator.validateEmptyText('Name', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                    ),
                    const SizedBox(
                      height: AppDefineSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: editController.phoneNumber,
                      validator: (value) =>
                          FormValidator.validatePhoneNumber(value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile),
                          labelText: 'Phone NUmber'),
                    ),
                    const SizedBox(
                      height: AppDefineSizes.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: editController.street,
                            validator: (value) =>
                                FormValidator.validateEmptyText('Name', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building_31),
                                labelText: 'Street'),
                          ),
                        ),
                        const SizedBox(
                          width: AppDefineSizes.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: editController.postCode,
                            validator: (value) =>
                                FormValidator.validateEmptyText('Name', value),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.code),
                                labelText: 'Postal Code'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppDefineSizes.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: editController.city,
                            validator: (value) =>
                                FormValidator.validateEmptyText('Name', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building),
                                labelText: 'City'),
                          ),
                        ),
                        const SizedBox(
                          width: AppDefineSizes.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: editController.stateOfCountry,
                            validator: (value) =>
                                FormValidator.validateEmptyText('Name', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.activity),
                                labelText: 'State'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppDefineSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: editController.country,
                      validator: (value) =>
                          FormValidator.validateEmptyText('Name', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.global),
                          labelText: 'Country'),
                    ),
                    const SizedBox(
                      height: AppDefineSizes.defaultSpace,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (editController.addressFormKey.currentState!
                              .validate()) {
                            context
                                .read<AddressBloc>()
                                .add(AddUserAddressEvent());
                          }
                        },
                        child: const Text('Save'),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
