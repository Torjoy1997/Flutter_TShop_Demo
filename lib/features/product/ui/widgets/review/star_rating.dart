import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class StarRatingBar extends StatelessWidget {
  const StarRatingBar({
    super.key,
    required this.rating,
    required this.itemSize,
    this.starColor = AppDefineColors.primary,
  });

  final double rating;
  final double itemSize;
  final Color? starColor;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        itemSize: itemSize,
        unratedColor: AppDefineColors.grey,
        itemBuilder: (_, __) => Icon(
              Iconsax.star1,
              color: starColor,
            ));
  }
}
