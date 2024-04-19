import 'package:ecommerce_demo/core/common_widgets/favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_shape/shape_for_homepage.dart';
import '../../../../../core/layout/custom_bar/appbar.dart';
import '../../../../../core/layout/rounded_image_layout.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../bloc/product_bloc.dart';

class ProductAppImageSlider extends StatefulWidget {
  const ProductAppImageSlider({
    super.key,
    required this.thumbnail,
    this.subImages = const [],
    required this.productId,
  });

  final String thumbnail;
  final List<String> subImages;
  final String productId;

  @override
  State<ProductAppImageSlider> createState() => _ProductAppImageSliderState();
}

class _ProductAppImageSliderState extends State<ProductAppImageSlider> {
  String _imageSwitcher = '';

  String get imageSwitcher {
    return _imageSwitcher.isEmpty ? widget.thumbnail : _imageSwitcher;
  }

  set imageSwitcher(String value) {
    _imageSwitcher = value;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is SetVariationValueState) {
          imageSwitcher = state.variations['image'];
        }
      },
      child: HomePageDesignShape(
        child: Container(
            color: AppHelperFunctions.isDarkMode(context)
                ? AppDefineColors.darkGrey
                : AppDefineColors.light,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is SetThumbnailImageState) {
                  imageSwitcher = state.imageUrl.isNotEmpty
                      ? state.imageUrl
                      : widget.thumbnail;
                }
                return Stack(
                  children: [
                    SizedBox(
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(
                            AppDefineSizes.productImageRadius * 2),
                        child: Center(
                            child: RoundedImageLayout(
                          width: 200,
                          imageUrl: imageSwitcher,
                          isNetworkImage: true,
                        )),
                      ),
                    ),
                    if (widget.subImages.isNotEmpty)
                      Positioned(
                          right: 0,
                          bottom: 30,
                          left: AppDefineSizes.defaultSpace,
                          child: SizedBox(
                            height: 80,
                            child: Center(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (_, index) => GestureDetector(
                                        onTap: () {
                                          context.read<ProductBloc>().add(
                                              SetThumbnailImageEvent(
                                                  imageUrl:
                                                      widget.subImages[index]));
                                        },
                                        child: RoundedImageLayout(
                                          width: 80,
                                          imageUrl: widget.subImages[index],
                                          border: Border.all(
                                              color: imageSwitcher ==
                                                      widget.subImages[index]
                                                  ? AppDefineColors.primary
                                                  : AppDefineColors.grey),
                                          padding: const EdgeInsets.all(
                                              AppDefineSizes.sm),
                                          backGroundColor:
                                              AppHelperFunctions.isDarkMode(
                                                      context)
                                                  ? AppDefineColors.dark
                                                  : AppDefineColors.white,
                                          isNetworkImage: true,
                                        ),
                                      ),
                                  separatorBuilder: (_, __) => const SizedBox(
                                        width: AppDefineSizes.spaceBtwItems,
                                      ),
                                  itemCount: widget.subImages.length),
                            ),
                          )),
                    CustomAppBar(
                      showBackArrow: true,
                      action: [FavouriteIcon(productId: widget.productId)],
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
