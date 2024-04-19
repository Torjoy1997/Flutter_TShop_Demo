
import 'package:flutter/material.dart';

import '../../../../core/layout/box_container_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CouponBox extends StatelessWidget {
  const CouponBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      showBorder: true,
      backGroundColor:
          AppHelperFunctions.isDarkMode(context) ? AppDefineColors.dark : AppDefineColors.white,
      padding: const EdgeInsets.only(
          top: AppDefineSizes.sm, bottom: AppDefineSizes.sm, right: AppDefineSizes.sm, left: AppDefineSizes.md),
      radius: 15,
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Have a Promo code? Enter Here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
            ),
          ),
          SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppHelperFunctions.isDarkMode(context)
                          ? AppDefineColors.white.withOpacity(0.5)
                          : AppDefineColors.dark.withOpacity(0.5),
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      side: BorderSide(color: Colors.grey.shade100)),
                  child: const Text('Apply')))
        ],
      ),
    );
  }
}
