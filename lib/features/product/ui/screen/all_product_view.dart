import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_demo/core/common_widgets/shimmer/vertical_card_shimmer.dart';
import 'package:ecommerce_demo/features/product/bloc/product_bloc.dart';
import 'package:ecommerce_demo/features/product/ui/widgets/product_drop_field.dart';

import '../../../../core/common_widgets/card/vertical_card.dart';
import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../core/layout/grid_layout.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/product.dart';
import '../../repos/product.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final ScrollController scrollController = ScrollController();
  String lastProductId = '';
  List<ProductModel> productData = [];
  int itemLength = 0;
  double height = 280.0;
  String? selectedValue;

  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductPaginateEvent());
    super.initState();
  }

  Future<void> _scrollListener() async {
    context
        .read<ProductBloc>()
        .add(ProductPaginateEvent(productId: lastProductId));

    return Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Popular Products'),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        //card data store
        listener: (context, state) {
          if (state is ProductPaginateLoaded) {
            productData = [...productData, ...state.paginateProducts];
            lastProductId =
                state.paginateProducts[state.paginateProducts.length - 1].id;
            itemLength = productData.isEmpty
                ? state.paginateProducts.length
                : productData.length;
            setState(() {
              selectedValue = null;
            });

            if (productData.length > 6) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent + 300.0,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeIn,
              );
            }
          }
          if (state is ProductPaginateLoading && productData.isEmpty) {
            itemLength = 6;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                        .sortProduct(value!, productData);
                    setState(() {
                      selectedValue = value;
                    });
                  }),
              const SizedBox(
                height: AppDefineSizes.spaceBtwSections,
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductPaginateLoading && productData.isEmpty) {
                    return Expanded(
                      child: GridLayout(
                          padding: const EdgeInsets.all(12),
                          itemCount: 6,
                          itemBuilder: (context, index) =>
                              const VerticalCardShimmer()),
                    );
                  }
                  //custom paginate widget
                  return Expanded(
                    child: CustomRefreshIndicator(
                      onRefresh: _scrollListener,
                      trigger: IndicatorTrigger.trailingEdge,
                      trailingScrollIndicatorVisible: false,
                      leadingScrollIndicatorVisible: true,
                      child: GridLayout(
                          padding: const EdgeInsets.all(12),
                          scrollController: scrollController,
                          itemCount: itemLength,
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return VerticalCardView(
                              productData: productData[index],
                            );
                          }),
                      builder: (BuildContext context, Widget child,
                          IndicatorController controller) {
                        return AnimatedBuilder(
                            animation: controller,
                            builder: (context, _) {
                              final dy = controller.value.clamp(0.0, 1.25) *
                                  -(height - (height * 0.20));

                              return Stack(
                                children: [
                                  Transform.translate(
                                    offset: Offset(0.0, dy),
                                    child: child,
                                  ),
                                  if (!controller.isComplete)
                                    Positioned(
                                        bottom: -height,
                                        left: 0,
                                        right: 0,
                                        height: height,
                                        child: Container(
                                          transform: Matrix4.translationValues(
                                              0.0, dy, 0.0),
                                          padding: const EdgeInsets.all(8),
                                          width: double.infinity,
                                          constraints:
                                              const BoxConstraints.expand(),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              VerticalCardShimmer(),
                                              VerticalCardShimmer()
                                            ],
                                          ),
                                        )),
                                ],
                              );
                            });
                      },
                    ),
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
