import 'package:ecommerce_demo/core/common_widgets/load_spinner.dart';
import 'package:ecommerce_demo/core/layout/rounded_image_layout.dart';
import 'package:ecommerce_demo/features/account/ui/widgets/account_edit_container.dart';
import 'package:ecommerce_demo/features/authentication/model/user.dart';
import 'package:ecommerce_demo/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../core/layout/section_headline_layout.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../bloc/account_bloc.dart';

class AccountInfoView extends StatelessWidget {
  const AccountInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userData = UserModel(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        profilePic: '');
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
          child: BlocConsumer<AccountBloc, AccountState>(
              listener: (context, state) {
            if (state is UserDataUpdateSuccess) {
              context.read<AccountBloc>().add(UserDataFetchEvent());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: MessageBar.successSnackBar(
                    title: 'Success', message: 'The data has been Update'),
                backgroundColor: Colors.transparent,
                behavior: SnackBarBehavior.floating,
                elevation: 0,
              ));
            }
            if (state is UserDataUpdateFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: MessageBar.errorSnackBar(
                    title: 'Oh! snap', message: state.errorMessage),
                backgroundColor: Colors.transparent,
                behavior: SnackBarBehavior.floating,
                elevation: 0,
              ));
            }
          }, builder: (context, state) {
            if (state is UserDataFetchSuccess) {
              userData = state.userData;
            }

            return Stack(
              children: [
                if (state is UserDataUpdateLoading)
                  Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.4,
                      left: MediaQuery.of(context).size.width * 0.3,
                      right: MediaQuery.of(context).size.width * 0.3,
                      child: const LoadingSpinner()),
                Column(children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        RoundedImageLayout(
                          imageUrl: userData.profilePic!.isNotEmpty
                              ? userData.profilePic!
                              : AppImages.user,
                          width: 80,
                          height: 80,
                          isNetworkImage: userData.profilePic != '',
                          borderRadius: 100,
                        ),
                        TextButton(
                            onPressed: () {
                              if (state is UserDataFetchSuccess) {
                                context.read<AccountBloc>().add(
                                    UserUploadImageEvent(
                                        imageUrl: state
                                                .userData.profilePic!.isNotEmpty
                                            ? state.userData.profilePic!
                                            : ''));
                              }
                            },
                            child: const Text('Change The profile pic..'))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems / 2,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  const SectionHeading(
                    title: 'Profile Information',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  AccountEditContainer(
                    title: 'First Name',
                    value: userData.firstName ?? '',
                    formValidator: (value) {
                      if (FormValidator.validateEmptyText(
                              'First Name', value) !=
                          null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: MessageBar.errorSnackBar(
                              title: 'Oh! Snap',
                              message: FormValidator.validateEmptyText(
                                      'First Name', value) ??
                                  ''),
                          backgroundColor: Colors.transparent,
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                        ));
                        return 'not validate';
                      }
                    },
                  ),
                  AccountEditContainer(
                    title: 'Last Name',
                    value: userData.lastName ?? '',
                    formValidator: (value) {
                      if (FormValidator.validateEmptyText('Last Name', value) !=
                          null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: MessageBar.errorSnackBar(
                              title: 'Oh! Snap',
                              message: FormValidator.validateEmptyText(
                                      'Last Name', value) ??
                                  ''),
                          backgroundColor: Colors.transparent,
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                        ));
                        return 'Not validate';
                      }
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  const SectionHeading(
                    title: 'Personal Information',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  AccountEditContainer(
                    title: 'User_ID',
                    value: userData.id ?? '',
                  ),
                  AccountEditContainer(
                    title: 'Email',
                    value: userData.email,
                  ),
                  AccountEditContainer(
                    title: 'Phone Number',
                    value: userData.phoneNumber ?? '',
                    formValidator: (value) {
                      if (FormValidator.validatePhoneNumber(value) != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: MessageBar.errorSnackBar(
                              title: 'Oh! Snap',
                              message:
                                  FormValidator.validatePhoneNumber(value) ??
                                      ''),
                          backgroundColor: Colors.transparent,
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                        ));
                        return 'Not validate';
                      }
                    },
                  ),
                  const AccountEditContainer(
                    title: 'Gender',
                    value: 'Male',
                  ),
                  const AccountEditContainer(
                    title: 'Birth_day',
                    value: '10th, Jun',
                  ),
                  const Divider(),
                  const SizedBox(
                    height: AppDefineSizes.spaceBtwItems,
                  ),
                  Center(
                    child: TextButton(
                      child: const Text(
                        'Close Account',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {},
                    ),
                  )
                ]),
              ],
            );
          }),
        ),
      ),
    );
  }
}
