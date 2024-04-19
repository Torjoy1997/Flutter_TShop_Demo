import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';


class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: AppDeviceUtils.getScreenWidth(context) * 0.5,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 11,
            backgroundColor: AppDefineColors.grey,
            borderRadius: BorderRadius.circular(7),
            valueColor: const AlwaysStoppedAnimation(AppDefineColors.primary),
          ),
        )
      ],
    );
  }
}
