import 'package:ecommerce_demo/core/common_widgets/shimmer/brand_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../core/layout/grid_layout.dart';
import '../../../../core/layout/section_headline_layout.dart';
import '../../../../utils/constants/sizes.dart';
import '../../bloc/store_bloc.dart';
import '../../model/brand.dart';
import '../widgets/brand/brand_container.dart';

class AllBrandsView extends StatelessWidget {
  const AllBrandsView({
    super.key,
    required this.brands,
  });

  final List<BrandModel> brands;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Brand'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
          child: Column(
            children: [
              const SectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwItems,
              ),
              BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  if (state is BrandLoadingState) {
                    return const BrandShimmer();
                  }
                  return GridLayout(
                    itemCount: brands.length,
                    itemBuilder: (_, index) => BrandContainer(
                      nameTitle: brands[index].name,
                      imageUrl: brands[index].image,
                      productCount: brands[index].productsCount,
                    ),
                    mainAxisExtent: 80,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
