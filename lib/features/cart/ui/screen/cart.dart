import 'package:ecommerce_demo/core/common_widgets/shimmer/button_shimmer.dart';
import 'package:ecommerce_demo/core/common_widgets/shimmer/cart_shimmer.dart';
import 'package:ecommerce_demo/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/custom_message_bar/message_bar.dart';
import '../../../../core/layout/custom_bar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/cart_item_model.dart';
import '../widgets/cart_menu_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.cartItems = const []});

  final List<CartItemModel> cartItems;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItemModel> cartData = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    if (widget.cartItems.isNotEmpty) {
      cartData = widget.cartItems;
      totalPrice = cartData
          .map((e) => e.price)
          .reduce((value, element) => value + element);
    }else{
      context.read<CartBloc>().add(FetchCartItemEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartItemRemoveState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MessageBar.successSnackBar(
                title: 'Cart Item Remove', message: 'Item Remove SuccessFully'),
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
          ));
        }
        if (state is CartItemLoadedState) {
          cartData = state.cartItems;
          totalPrice = cartData
              .map((e) => e.price)
              .reduce((value, element) => value + element);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          showBackArrow: true,
          title: Text(
            'Cart',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        bottomNavigationBar:  BlocBuilder<CartBloc,CartState>(
          builder:(context,state){
            if(state is CartItemLoadingState || cartData.isEmpty){
              return const ButtonShimmer();
            }
            return Padding(
              padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed('CheckOut', extra: {
                    'cartData': cartData,
                    'totalPrice': totalPrice
                  });
                },
                child: Text('Process Out € $totalPrice'),
              ),
            );
          }
        )
            ,
        body: Padding(
          padding: const EdgeInsets.all(AppDefineSizes.defaultSpace),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartItemLoadingState) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (_, index) => const CartShimmer(),
                    separatorBuilder: (_, __) => const SizedBox(
                          height: AppDefineSizes.spaceBtwSections,
                        ),
                    itemCount: 5);
              }
              if (cartData.isEmpty) {
                return Center(
                  child: Text(
                    'There is No Data',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: AppDefineColors.grey),
                  ),
                );
              }
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, index) => Column(
                        children: [
                          CartMenuItem(
                            cartId: cartData[index].id,
                            title: cartData[index].title,
                            quantity: cartData[index].quantity,
                            image: cartData[index].image,
                            brandData: cartData[index].brandData,
                            price: cartData[index].price,
                            variations: cartData[index].selectedVariation ?? {},
                          )
                        ],
                      ),
                  separatorBuilder: (_, __) => const SizedBox(
                        height: AppDefineSizes.spaceBtwSections,
                      ),
                  itemCount: cartData.length);
            },
          ),
        ),
      ),
    );
  }
}
