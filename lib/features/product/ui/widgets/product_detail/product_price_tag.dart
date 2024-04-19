import 'package:ecommerce_demo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ProductPriceTag extends StatelessWidget {
  const ProductPriceTag(
      {super.key,

      required this.price,
      this.maxLines = 1,
      this.isLarge = true,
      this.lineThrough = false,  this.isForCard = false});

  final String price;
  final int maxLines;
  final bool isLarge, lineThrough,isForCard;

  @override
  Widget build(BuildContext context) {

    return Text(
      price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,color: isForCard ? AppDefineColors.black : null)
          : Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,color: isForCard ? AppDefineColors.black : null),
    );
  }
}
