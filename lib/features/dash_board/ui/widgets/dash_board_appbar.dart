import 'package:ecommerce_demo/core/common_widgets/badge.dart';
import 'package:flutter/material.dart';

import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';

class DashBoardAppBar extends StatelessWidget {
  const DashBoardAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppDefineTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: AppDefineColors.grey),
          ),
          Text(
            AppDefineTexts.homeAppbarSubTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: AppDefineColors.white),
          )
        ],
      ),
      action: const [AppBadge()],
    );
  }
}
