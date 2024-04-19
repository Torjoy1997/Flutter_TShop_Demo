import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../widgets/auth_info_detail.dart';

class VerifyEmailSuccessScreen extends StatelessWidget {
  const VerifyEmailSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: AuthInfoSection(
        imageUrl: AppImages.staticSuccessIllustration,
        title: AppDefineTexts.yourAccountCreatedTitle,
        subTitle: AppDefineTexts.yourAccountCreatedSubTitle,
        buttonList: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text(AppDefineTexts.tContinue),
            ),
          ),
        ],
      ),
    );
  }
}