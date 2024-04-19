import 'package:ecommerce_demo/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_demo/features/cart/model/cart_item_model.dart';
import 'package:ecommerce_demo/features/product/bloc/product_bloc.dart';
import 'package:ecommerce_demo/features/product/model/product.dart';
import 'package:ecommerce_demo/features/store/model/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../../core/common_widgets/load_spinner.dart';
import '../../../../core/layout/section_headline_layout.dart';
import '../../../../utils/constants/sizes.dart';
import '../../repos/product.dart';
import '../widgets/product_detail/prduct_interaction.dart';
import '../widgets/product_detail/product_bottom_action.dart';
import '../widgets/product_detail/product_image_silder.dart';
import '../widgets/product_detail/product_meta_info.dart';
import '../widgets/product_detail/rate_share.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.id});
  final String id;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductModel productData = ProductModel.empty();
  Map<String, dynamic> variation = {};
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductFetchEvent(productId: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is SingleProductFetchLoaded) {
              productData = state.product;
            }
            if (state is SetVariationValueState) {
              if (state.variations.isNotEmpty) {
                variation = state.variations;
              }
            }
          },
        ),
        BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartItemAddState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: MessageBar.successSnackBar(
                    title: 'Cart Item', message: 'Item Add SuccessFully'),
                backgroundColor: Colors.transparent,
                behavior: SnackBarBehavior.floating,
                elevation: 0,
              ));
            }

            if (state is CartItemError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: MessageBar.errorSnackBar(
                    title: 'Oh! Snap', message: state.errorMessage),
                backgroundColor: Colors.transparent,
                behavior: SnackBarBehavior.floating,
                elevation: 0,
              ));
            }
          },
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: ProductBottomAction(
          productId: widget.id,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductFetchLoading || productData.title.isEmpty) {
              return const Center(
                child: LoadingBouncer(),
              );
            }
            return SingleChildScrollView(
              child: Column(children: [
                ProductAppImageSlider(
                  thumbnail: productData.thumbnail,
                  subImages: productData.images ?? [],
                  productId: productData.id,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: AppDefineSizes.defaultSpace,
                      left: AppDefineSizes.defaultSpace,
                      bottom: AppDefineSizes.defaultSpace),
                  child: Column(
                    children: [
                      const RatingAndShare(),
                      ProductMetaData(
                        productTitle: productData.title,
                        discount: context
                            .read<ProductRepository>()
                            .calculateSalePercentage(
                                productData.price, productData.salePrice),
                        salePrice: context
                            .read<ProductRepository>()
                            .getProductPrice(productData),
                        price: productData.price.toString(),
                        brand: productData.brand ?? BrandModel.empty(),
                        stock: productData.stock,
                        isVariation: productData.productVariations != null ?true:  false,
                      ),
                      ProductActionAttribute(
                        productAttribute: productData.productAttributes ?? [],
                        productType: productData.productType,
                        productVariation: productData.productVariations,
                      ),
                      const SizedBox(
                        height: AppDefineSizes.spaceBtwSections,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              final totalPrice = variation['price'] != null
                                  ? double.parse(variation['price'].toString())
                                  : productData.price.toDouble();

                              context.pushNamed('CheckOut', extra: {
                                'cartData': [
                                  CartItemModel(
                                      quantity: 1,
                                      image: variation['image'] ??
                                          productData.thumbnail,
                                      title: productData.title,
                                      brandData: productData.brand!,
                                      price: totalPrice,
                                      selectedVariation: variation)
                                ],
                                'totalPrice': totalPrice
                              });
                            },
                            child: const Text('Checkout')),
                      ),
                      const SizedBox(
                        height: AppDefineSizes.spaceBtwSections,
                      ),
                      const SectionHeading(
                        title: 'Description',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        height: AppDefineSizes.spaceBtwItems,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ReadMoreText(
                          productData.description ?? '',
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Less',
                          textAlign: TextAlign.justify,
                          moreStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                          lessStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: AppDefineSizes.spaceBtwItems,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SectionHeading(
                            title: 'Review(199)',
                            onPressed: () {},
                            showActionButton: false,
                          ),
                          IconButton(
                              onPressed: () {
                                context.pushNamed('product_review');
                              },
                              icon: const Icon(Iconsax.arrow_right_3)),
                        ],
                      ),
                      const SizedBox(
                        height: AppDefineSizes.spaceBtwSections,
                      ),
                    ],
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
