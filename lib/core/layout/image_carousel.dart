import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_demo/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class ImageCarouselLayout extends StatelessWidget {
  const ImageCarouselLayout(
      {super.key,
      this.onPressed,
      this.width,
      this.height,
      this.borderRadius = AppDefineSizes.md,
      this.isImageNetwork = false,
      this.applyImageRadius = true,
      this.fit = BoxFit.contain,
      required this.imageUrl});

  final VoidCallback? onPressed;
  final double? width, height;
  final String imageUrl;
  final double borderRadius;
  final bool isImageNetwork;
  final BoxFit? fit;
  final bool applyImageRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
          child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child: isImageNetwork
                ? CachedNetworkImage(
                    fit: fit,
                    imageUrl: imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const AppShimmerEffect(height: 100, width: 305),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image(fit: fit, image: AssetImage(imageUrl) as ImageProvider),
          ),
        ));
  }
}
