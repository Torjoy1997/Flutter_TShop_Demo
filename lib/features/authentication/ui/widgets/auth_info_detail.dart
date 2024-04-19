import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';


class AuthInfoSection extends StatelessWidget {
  const AuthInfoSection(
      {super.key,
        required this.imageUrl,
        required this.title,
        required this.subTitle,
        this.isSubHead = false,
        this.buttonList,
        this.email});

  final String imageUrl;
  final String title;
  final String subTitle;
  final String? email;
  final bool isSubHead;
  final List<Widget>? buttonList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: AssetImage(imageUrl),
                width: AppHelperFunctions.screenWidth(context) * 0.6,
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwItems,
              ),
              if (isSubHead) ...[
                Text(
                  email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppDefineSizes.spaceBtwSections,
                ),
              ],
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              ...buttonList!
            ],
          ),
        ));
  }
}