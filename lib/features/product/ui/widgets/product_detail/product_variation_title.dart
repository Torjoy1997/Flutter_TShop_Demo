import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TitleValue extends StatelessWidget {
  const TitleValue({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title : ',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: AppDefineColors.darkerGrey),
        ),
        const SizedBox(
          width: AppDefineSizes.spaceBtwItems,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
