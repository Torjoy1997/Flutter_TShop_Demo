import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
part 'brand_headline_icon.dart';

class BrandHeadline extends StatelessWidget {
  const BrandHeadline({
    super.key,
    required this.title,
    this.imageUrl,
    this.subTitle,
    this.applySmallImage = false,
  });

  final String title;
  final String? subTitle;

  final String? imageUrl;
  final bool applySmallImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Image(
            image: AssetImage(imageUrl!),
            color: AppHelperFunctions.isDarkMode(context)
                ? AppDefineColors.white
                : AppDefineColors.dark,
            height: applySmallImage ? 32 : 80,
            width: applySmallImage ? 32 : 80,
          ),
        ),
        const SizedBox(
          width: AppDefineSizes.spaceBtwItems / 2,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BrandHeadlineWithIcon(
              title: title,
            ),
            const SizedBox(
              height: 8,
            ),
            if (subTitle != null)
              Text(
                subTitle!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium,
              )
          ],
        )
      ],
    );
  }
}
