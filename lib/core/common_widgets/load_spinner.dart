import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingBouncer extends StatelessWidget {
  const LoadingBouncer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.cyan,
        size: 50,
      ),
    );
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      padding: const EdgeInsets.all(AppDefineSizes.iconMd),
      radius: 15,
      backGroundColor: Colors.black.withOpacity(0.5),
      alignment: Alignment.center,
      child: const Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
