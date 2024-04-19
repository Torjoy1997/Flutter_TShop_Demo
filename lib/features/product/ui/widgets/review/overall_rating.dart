import 'package:ecommerce_demo/features/product/ui/widgets/review/rating_linear_progress.dart';
import 'package:flutter/material.dart';


class OverAllRating extends StatelessWidget {
  const OverAllRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text(
              '4.8',
              style: Theme.of(context).textTheme.displayLarge,
            )),
        const Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingProgressIndicator(
                  label: '5',
                  value: 1,
                ),
                RatingProgressIndicator(
                  label: '4',
                  value: 0.8,
                ),
                RatingProgressIndicator(
                  label: '3',
                  value: 0.6,
                ),
                RatingProgressIndicator(
                  label: '2',
                  value: 0.4,
                ),
                RatingProgressIndicator(
                  label: '1',
                  value: 0.5,
                )
              ],
            ))
      ],
    );
  }
}
