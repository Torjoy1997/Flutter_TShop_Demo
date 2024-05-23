import 'package:ecommerce_demo/core/common_widgets/error_screen.dart';
import 'package:ecommerce_demo/core/common_widgets/load_spinner.dart';
import 'package:ecommerce_demo/core/custom_shape/shape_for_homepage.dart';
import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/features/account/ui/widgets/account_setting_list.dart';
import 'package:ecommerce_demo/features/authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../core/layout/rounded_image_layout.dart';
import '../../../../core/layout/section_headline_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../bloc/account_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    context.read<AccountBloc>().add(UserDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogoutState) {
              context.goNamed('login');
            }
          },
        ),
      ],
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is UserDataFetchLoading) {
            return const LoadingBouncer();
          } else if (state is UserDataFetchSuccess) {
            return Scaffold(
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  HomePageDesignShape(
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: AppDefineColors.gradientColorBackground),
                      padding: const EdgeInsets.all(0),
                      child: Stack(
                        children: [
                          Positioned(
                              top: -150,
                              right: -250,
                              child: BoxContainer(
                                backGroundColor:
                                    AppDefineColors.white.withOpacity(0.1),
                              )),
                          Positioned(
                              top: 100,
                              right: -300,
                              child: BoxContainer(
                                backGroundColor:
                                    AppDefineColors.white.withOpacity(0.1),
                              )),
                          Column(
                            children: [
                              CustomAppBar(
                                showBackArrow: false,
                                title: Text(
                                  'Account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .apply(color: AppDefineColors.white),
                                ),
                              ),
                              ListTile(
                                leading: RoundedImageLayout(
                                  imageUrl:
                                      state.userData.profilePic!.isNotEmpty
                                          ? state.userData.profilePic!
                                          : AppImages.user,
                                  width: 60,
                                  height: 60,
                                  isNetworkImage:
                                      state.userData.profilePic != '',
                                  borderRadius: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  state.userData.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply(color: AppDefineColors.white),
                                ),
                                subtitle: Text(
                                  state.userData.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(color: AppDefineColors.white),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    context.pushNamed('AccountDetail');
                                  },
                                  icon: const Icon(
                                    Iconsax.edit,
                                    color: AppDefineColors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: AppDefineSizes.spaceBtwSections,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
                    child: Column(
                      children: [
                        const SectionHeading(
                          title: 'Account Setting',
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: AppDefineSizes.spaceBtwItems,
                        ),
                        ...AppDefineTexts.settingList
                            .map((settingInfo) => ListOfSetting(
                                  icon: settingInfo['icon'],
                                  title: settingInfo['title'],
                                  subTitle: settingInfo['subTitle'],
                                  onTap: () {
                                    settingInfo['onTap'](context);
                                  },
                                  key: UniqueKey(),
                                ))
                            .toList(),
                        const SizedBox(
                          height: AppDefineSizes.spaceBtwSections,
                        ),
                        const SectionHeading(
                          title: 'App Setting',
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: AppDefineSizes.spaceBtwItems,
                        ),
                        ListOfSetting(
                          icon: Iconsax.document_upload,
                          title: 'Load Data',
                          subTitle: 'Upload data to your cloud database',
                          onTap: () {},
                        ),
                        ...AppDefineTexts.settingListWithToggle
                            .map((e) => ListOfSetting(
                                  icon: e['icon'],
                                  title: e['title'],
                                  subTitle: e['subTitle'],
                                  trailing: e['trailing'],
                                ))
                            .toList(),
                        const SizedBox(
                          height: AppDefineSizes.spaceBtwSections,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(LogOutEvent());
                              },
                              child: const Text('LogOut')),
                        ),
                        const SizedBox(
                          height: AppDefineSizes.spaceBtwSections * 2.5,
                        )
                      ],
                    ),
                  )
                ],
              )),
            );
          } else {
            return ErrorScreen(
                message: state is UserDataFetchFailure
                    ? state.errorMessage
                    : 'Something went Wrong');
          }
        },
      ),
    );
  }
}
