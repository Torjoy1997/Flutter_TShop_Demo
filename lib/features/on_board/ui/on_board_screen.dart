import 'package:ecommerce_demo/features/on_board/cubit/on_board_cubit.dart';
import 'package:ecommerce_demo/features/on_board/ui/widgets/on_board_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    bool mode = AppHelperFunctions.isDarkMode(context);
    return BlocConsumer<OnBoardCubit, OnBoardState>(
      listener: (context, state) {
        if (state is OnBoardFinished) {
          context.goNamed('login');
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Stack(children: [
          PageView(
            controller: context.read<OnBoardCubit>().pageController,
            onPageChanged: context.read<OnBoardCubit>().updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: AppImages.onBoardingImage1,
                title: AppDefineTexts.onBoardingTitle1,
                subTitle: AppDefineTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage2,
                title: AppDefineTexts.onBoardingTitle2,
                subTitle: AppDefineTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage3,
                title: AppDefineTexts.onBoardingTitle3,
                subTitle: AppDefineTexts.onBoardingSubTitle3,
              )
            ],
          ),

          //skip button
          Positioned(
              top: AppDeviceUtils.getAppBarHeight(),
              right: AppDefineSizes.defaultSpace,
              child: TextButton(
                onPressed: () {
                  context.read<OnBoardCubit>().skipPage();
                },
                child: const Text('Skip'),
              )),

          //dot indicator
          Positioned(
              bottom: AppDeviceUtils.getBottomNavigationBarHeight() + 25,
              left: AppDefineSizes.defaultSpace,
              child: SmoothPageIndicator(
                controller: context.read<OnBoardCubit>().pageController,
                onDotClicked: context.read<OnBoardCubit>().dotNavigationClick,
                count: 3,
                effect: ExpandingDotsEffect(
                    activeDotColor:
                        mode ? AppDefineColors.light : AppDefineColors.dark,
                    dotHeight: 6),
              )),

          //elevated button
          Positioned(
              bottom: AppDeviceUtils.getBottomNavigationBarHeight(),
              right: AppDefineSizes.defaultSpace,
              child: ElevatedButton(
                onPressed: () {
                  context.read<OnBoardCubit>().nextPage();
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor:
                        mode ? AppDefineColors.primary : AppDefineColors.black),
                child: const Icon(Icons.keyboard_arrow_right),
              ))
        ]));
      },
    );
  }
}
