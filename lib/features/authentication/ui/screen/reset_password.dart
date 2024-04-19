import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../widgets/auth_info_detail.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AuthInfoSection(
        imageUrl: AppImages.deliveredEmailIllustration,
        title: AppDefineTexts.changeYourPasswordTitle,
        subTitle: AppDefineTexts.changeYourPasswordSubTitle,
        buttonList: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text(AppDefineTexts.done),
            ),
          ),
          const SizedBox(
            height: AppDefineSizes.spaceBtwInputFields,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              child: const Text(AppDefineTexts.resendEmail),
            ),
          ),
        ],
      ),
    );
  }
}