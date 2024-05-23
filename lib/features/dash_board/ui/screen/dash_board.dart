import 'package:ecommerce_demo/core/common_widgets/shimmer/vertical_card_shimmer.dart';
import 'package:ecommerce_demo/core/layout/box_container_layout.dart';
import 'package:ecommerce_demo/features/dash_board/ui/widgets/dash_board_appbar.dart';
import 'package:ecommerce_demo/features/network_manager/cubit/network_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/common_widgets/card/vertical_card.dart';
import '../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../Autocomplete/ui/search_box.dart';
import '../../../../core/custom_shape/shape_for_homepage.dart';
import '../../../../core/layout/grid_layout.dart';
import '../../../../core/layout/section_headline_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../product/bloc/product_bloc.dart';
import '../../../product/model/product.dart';
import '../../../wish_list/bloc/wish_list_bloc.dart';
import '../../bloc/dashboard_bloc.dart';
import '../widgets/carousel.dart';
import '../widgets/items_horz_categories.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<ProductModel> productData = [];
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(BannerSetEvent());
    context.read<ProductBloc>().add(const ProductFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductFetchLoaded) {
              productData = state.products;
            }
          },
        ),
        BlocListener<WishListBloc, WishListState>(listener: (context, state) {
          if (state is WishListAddState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: MessageBar.successSnackBar(
                  title: 'WishList',
                  message: 'Added the product your WishList'),
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
            ));
          }
          if (state is WishListRemoveState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: MessageBar.infoSnackBar(
                  title: 'WishList Remove',
                  message: 'Remove the product your WishList'),
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
            ));
          }
        }),
        BlocListener<NetworkCubit, NetworkState>(
          listener: (context, state) {
            if (state is NetworkDisConnected) {
              context.goNamed('DisConnectPage');
            }
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              HomePageDesignShape(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: AppDefineColors.gradientColorBackground),
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    children: [
                      Positioned(
                          top: -150,
                          right: -250,
                          child: BoxContainer(
                            backGroundColor:
                                AppDefineColors.white.withOpacity(0.1),
                          )),
                      Positioned(
                          top: 100,
                          right: -300,
                          child: BoxContainer(
                            backGroundColor:
                                AppDefineColors.white.withOpacity(0.1),
                          )),
                      const Column(
                        children: [
                          DashBoardAppBar(),
                          SizedBox(
                            height: AppDefineSizes.spaceBtwSections,
                          ),
                          CustomSearchBox(
                            textSearch: 'Search in Store',
                            icon: Iconsax.search_normal,
                          ),
                          SizedBox(
                            height: AppDefineSizes.spaceBtwSections,
                          ),
                          HorizontalViewOfItem(),
                          SizedBox(
                            height: AppDefineSizes.spaceBtwSections,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              //image_silder
              const CarouselView(),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections / 2,
              ),

              // product VerticalCardView()
              SectionHeading(
                  title: 'Popular Products',
                  buttonTitle: 'view all',
                  onPressed: () {
                    context.pushNamed('AllProductsView');
                  }),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductFetchLoading || productData.isEmpty) {
                    return GridLayout(
                        padding: const EdgeInsets.all(12),
                        itemCount: 4,
                        itemBuilder: (context, index) =>
                            const VerticalCardShimmer());
                  }

                  return GridView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppDefineSizes.gridViewSpacing,
                              crossAxisSpacing: AppDefineSizes.gridViewSpacing,
                              mainAxisExtent: 288),
                      itemBuilder: (context, index) => VerticalCardView(
                            productData: productData[index],
                          ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
