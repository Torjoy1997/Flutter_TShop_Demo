import 'package:ecommerce_demo/core/common_widgets/badge.dart';
import 'package:ecommerce_demo/core/common_widgets/shimmer/brand_wth_product.dart';
import 'package:ecommerce_demo/features/store/ui/widgets/brand/brand_container.dart';
import 'package:ecommerce_demo/features/store/ui/widgets/store_tab_section/sports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Autocomplete/ui/search_box.dart';
import '../../../../core/common_widgets/shimmer/brand_shimmer.dart';
import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../core/layout/custom_bar/tabbar.dart';
import '../../../../core/layout/grid_layout.dart';
import '../../../../core/layout/section_headline_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../network_manager/cubit/network_cubit.dart';
import '../../bloc/store_bloc.dart';
import '../../model/brand.dart';
import '../../model/category.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    context.read<StoreBloc>().add(BrandEvent());
    context.read<StoreBloc>().add(CategoryProductsEvent());
    super.initState();
  }

  List<BrandModel> brands = [];
  List<CategoryModel> categoryData = [];

  @override
  Widget build(BuildContext context) {
    // int currentIndex = _tabController.index;

    return MultiBlocListener(
      listeners: [
        BlocListener<StoreBloc, StoreState>(
          listener: (context, state) {
            if (state is BrandLoadedState) {
              brands = state.brands;
            }

            if (state is CategoryProductsLoaded) {
              categoryData = state.categoryData;
            }
          },
        ),
        BlocListener<NetworkCubit, NetworkState>(
          listener: (context, state) {
            if (state is NetworkDisConnected) {
              context.goNamed('DisConnectPage');
            }
          },
        ),
      ],
      child: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: CustomAppBar(
              showBackArrow: false,
              title: Text(
                'Store',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              action: const [AppBadge()],
            ),
            body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: AppHelperFunctions.isDarkMode(context)
                        ? AppDefineColors.black
                        : AppDefineColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding:
                          const EdgeInsets.all(AppDefineSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const SizedBox(
                            height: AppDefineSizes.spaceBtwItems,
                          ),
                          const CustomSearchBox(
                            textSearch: 'Search in Store',
                            icon: Iconsax.search_normal,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(
                            height: AppDefineSizes.spaceBtwSections,
                          ),
                          SectionHeading(
                              title: 'Features Brands',
                              onPressed: () {
                                context.push('/store/brands', extra: brands);
                              }),
                          const SizedBox(
                            height: AppDefineSizes.spaceBtwItems / 1.5,
                          ),
                          BlocBuilder<StoreBloc, StoreState>(
                            builder: (context, state) {
                              if (state is BrandLoadingState) {
                                return const BrandShimmer();
                              }
                              if (brands.isNotEmpty) {
                                return GridLayout(
                                  itemCount: 4,
                                  itemBuilder: (_, index) => BrandContainer(
                                    nameTitle: brands[index].name,
                                    imageUrl: brands[index].image,
                                    productCount: brands[index].productsCount,
                                  ),
                                  mainAxisExtent: 80,
                                );
                              } else {
                                return const BrandShimmer();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    bottom: CustomTabBar(
                        tabs: <String>[
                      'Sports',
                      'Furniture',
                      'Electronics',
                      'Clothes',
                      'Cosmetics'
                    ]
                            .map((e) => Tab(
                                  child: Text(e),
                                ))
                            .toList()),
                  )
                ];
              },
              body: BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  if (state is CategoryProductsLoading ||
                      categoryData.isEmpty) {
                    return TabBarView(children: [
                      for (int i = 0; i < 5; i++)
                        const SingleChildScrollView(
                          child: Padding(
                            padding:
                                EdgeInsets.all(AppDefineSizes.defaultSpace),
                            child: BrandWithProductShimmer(),
                          ),
                        )
                    ]);
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: TabBarView(
                        children: categoryData
                            .map((category) => SportsTabView(
                                  categoryData: category,
                                  brands: brands,
                                ))
                            .toList()),
                  );
                },
              ),
            ),
          )),
    );
  }
}
