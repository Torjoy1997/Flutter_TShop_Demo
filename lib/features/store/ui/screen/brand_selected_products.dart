import 'package:ecommerce_demo/core/layout/custom_bar/appbar.dart';
import 'package:ecommerce_demo/core/layout/section_headline_layout.dart';
import 'package:ecommerce_demo/features/store/model/brand.dart';
import 'package:ecommerce_demo/features/store/ui/widgets/brand/brand_container.dart';

import 'package:ecommerce_demo/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/card/vertical_card.dart';
import '../../../../core/common_widgets/shimmer/vertical_card_shimmer.dart';
import '../../../../core/layout/grid_layout.dart';

import '../../../product/model/product.dart';
import '../../../product/repos/product.dart';

import '../../../product/ui/widgets/product_drop_field.dart';
import '../../bloc/store_bloc.dart';

class BrandSelectedProducts extends StatefulWidget {
  const BrandSelectedProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  State<BrandSelectedProducts> createState() => _BrandSelectedProductsState();
}

class _BrandSelectedProductsState extends State<BrandSelectedProducts> {
  List<ProductModel> productDatas = [];
  String? selectedValue;
  @override
  void initState() {
    context
        .read<StoreBloc>()
        .add(SelectedBrandEvent(brandName: widget.brand.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(widget.brand.name),
      ),
      body: BlocListener<StoreBloc, StoreState>(
        listener: (context, state) {
          if (state is SelectedBrandLoaded) {
            productDatas = state.brandProducts;
            setState(() {
              selectedValue = null;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              BrandContainer(
                nameTitle: widget.brand.name,
                productCount: widget.brand.productsCount,
                imageUrl: widget.brand.image,
              ),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              const SectionHeading(
                title: 'Products',
                showActionButton: false,
              ),
              ProductSortDropdown(
                  selectedValue: selectedValue,
                  sortItems: const [
                    'Name',
                    'Higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popuarity'
                  ],
                  onPressed: (value) {
                    context
                        .read<ProductRepository>()
                        .sortProduct(value!, productDatas);
                    setState(() {
                      selectedValue = value;
                    });
                  }),
              BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  if (state is SelectedBrandLoading) {
                    return Expanded(
                      child: GridLayout(
                          padding: const EdgeInsets.all(12),
                          itemCount: 6,
                          itemBuilder: (context, index) =>
                              const VerticalCardShimmer()),
                    );
                  }
                  // brand product card
                  return Expanded(
                    child: GridLayout(
                        padding: const EdgeInsets.all(6),
                        itemCount: productDatas.length,
                        itemBuilder: (context, index) {
                          return VerticalCardView(
                            productData: productDatas[index],
                          );
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
