import 'package:ecommerce_demo/features/product/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/common_widgets/card/vertical_card.dart';
import '../../../core/common_widgets/shimmer/vertical_card_shimmer.dart';
import '../../../core/layout/custom_bar/appbar.dart';
import '../../../core/layout/grid_layout.dart';

import '../bloc/wish_list_bloc.dart';

class WishListView extends StatefulWidget {
  const WishListView({super.key});

  @override
  State<WishListView> createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  List<ProductModel> _wishListProduct = [];

  @override
  void initState() {
    context.read<WishListBloc>().add(WishListProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishListBloc, WishListState>(
      listener: (context, state) {
        if (state is WishListLoadedState) {
          _wishListProduct = state.wishProduct;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          showBackArrow: false,
          title: Text(
            'WishList',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          action: [IconButton(onPressed: () {}, icon: const Icon(Iconsax.add))],
        ),
        body: BlocBuilder<WishListBloc, WishListState>(
          builder: (context, state) {
            if (state is WishListLoadingState) {
              return GridLayout(
                  padding: const EdgeInsets.all(8),
                  itemCount: 4,
                  itemBuilder: (context, index) => const VerticalCardShimmer());
            }
            //card of wishlist Product
            return Padding(
              padding: const EdgeInsets.all(8),
              child: GridLayout(
                  padding: const EdgeInsets.all(12),
                  itemCount: _wishListProduct.length,
                  scrollPhysics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return VerticalCardView(
                      productData: _wishListProduct[index],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
