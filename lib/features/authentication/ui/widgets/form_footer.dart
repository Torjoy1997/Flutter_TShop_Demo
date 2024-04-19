import 'package:ecommerce_demo/features/authentication/bloc/auth_bloc.dart';
import 'package:ecommerce_demo/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class FormOfFooter extends StatelessWidget {
  const FormOfFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (AppHelperFunctions.getPlatform() != 'ios')
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppDefineColors.grey),
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignInWithGoogleEvent());
                },
                icon: const Image(
                    width: AppDefineSizes.iconMd,
                    height: AppDefineSizes.iconMd,
                    image: AssetImage(AppImages.google))),
          ),
        const SizedBox(
          width: AppDefineSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppDefineColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                  width: AppDefineSizes.iconMd,
                  height: AppDefineSizes.iconMd,
                  image: AssetImage(AppImages.facebook))),
        ),
      ],
    );
  }
}
