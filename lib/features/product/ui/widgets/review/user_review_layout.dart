
import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/features/product/ui/widgets/review/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class UserReviewLayout extends StatelessWidget {
  const UserReviewLayout(
      {super.key,
      required this.imageUrl,
      required this.reviewText,
      required this.reviewerName,
      required this.reviewerRating,
      this.greeting =
          'Thank you for choosing us as your product provider. It\'s our pleasure to have you on board, and we are committed to ensuring your experience with us is nothing short of exceptional.'});

  final String imageUrl, reviewText, reviewerName, greeting;
  final double reviewerRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imageUrl),
                ),
                const SizedBox(
                  width: AppDefineSizes.spaceBtwItems,
                ),
                Text(
                  reviewerName,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        Row(
          children: [
            StarRatingBar(rating: reviewerRating, itemSize: 20),
            const SizedBox(
              width: AppDefineSizes.spaceBtwItems,
            ),
            Text(
              '01,Nov 2023',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          width: AppDefineSizes.spaceBtwItems,
        ),
        ReadMoreText(
          reviewText,
          trimLines: 3,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          trimMode: TrimMode.Line,
          moreStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppDefineColors.primary),
          lessStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppDefineColors.primary),
        ),
        const SizedBox(
          height: AppDefineSizes.spaceBtwItems,
        ),
        BoxContainer(
          radius: 10,
          backGroundColor: AppHelperFunctions.isDarkMode(context)
              ? AppDefineColors.darkerGrey
              : AppDefineColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(AppDefineSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Flutter Store',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '02 Nov,2023',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(
                  width: AppDefineSizes.spaceBtwItems,
                ),
                ReadMoreText(
                  greeting,
                  trimLines: 3,
                  trimExpandedText: 'show less',
                  trimCollapsedText: 'show more',
                  trimMode: TrimMode.Line,
                  moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppDefineColors.primary),
                  lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppDefineColors.primary),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
