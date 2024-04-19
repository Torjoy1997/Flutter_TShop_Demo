import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';


class TextBetweenDivider extends StatelessWidget {
  const TextBetweenDivider(
      {super.key, required this.syMode, required this.dividerText});

  final bool syMode;
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: syMode ? AppDefineColors.darkGrey : AppDefineColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: syMode ? AppDefineColors.darkGrey : AppDefineColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        )
      ],
    );
  }
}