
import 'package:flutter/material.dart';

import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../widgets/review/overall_rating.dart';
import '../widgets/review/star_rating.dart';
import '../widgets/review/user_review_layout.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Review & Rating'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and Reviews are Verified .customers give feedback about the product. we belive that this is the way to acknowledge the product quality to other customer '),
              const SizedBox(
                height: AppDefineSizes.spaceBtwItems,
              ),
              const OverAllRating(),
              const StarRatingBar(
                rating: 4.5,
                itemSize: 20,
              ),
              Text(
                '12,116',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              const UserReviewLayout(
                imageUrl: AppImages.user,
                reviewText:
                'The shoe offers a roomy and snug fit, providing ample support without sacrificing comfort. The [lace system/adjustable straps] allows for a customizable fit according to individual preferences.',
                reviewerName: 'Jone Doe',
                reviewerRating: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}