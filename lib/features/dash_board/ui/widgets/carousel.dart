import 'package:carousel_slider/carousel_slider.dart';

import 'package:ecommerce_demo/core/layout/image_carousel.dart';
import 'package:ecommerce_demo/features/dash_board/model/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../core/layout/box_container_layout.dart';
import '../../bloc/dashboard_bloc.dart';

class CarouselView extends StatefulWidget {
  const CarouselView({super.key});

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
        child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
          List<BannerModel> bannerImage = [];
          if (state is BannerFetchSuccess) {
            bannerImage = state.bannerModels;
          }
          return Column(
            children: [
              CarouselSlider(
                  items: bannerImage
                      .map((banner) => ImageCarouselLayout(
                            imageUrl: banner.imageUrl,
                            isImageNetwork: true,
                          ))
                      .toList(),
                  options: CarouselOptions(
                      viewportFraction: 1,
                      onPageChanged: (index, _) {
                        setState(() {
                          currentIndex = index;
                        });
                      })),
              const SizedBox(
                height: AppDefineSizes.spaceBtwItems,
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < bannerImage.length; i++)
                      BoxContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        backGroundColor: currentIndex == i
                            ? AppDefineColors.primary
                            : AppDefineColors.grey,
                      )
                  ],
                ),
              )
            ],
          );
        }));
  }
}
