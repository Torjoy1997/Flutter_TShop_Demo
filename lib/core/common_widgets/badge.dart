import 'package:ecommerce_demo/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../utils/constants/colors.dart';
import '../../features/cart/model/cart_item_model.dart';
import '../../utils/helpers/helper_functions.dart';

class AppBadge extends StatefulWidget {
  const AppBadge({super.key});

  @override
  State<AppBadge> createState() => _AppBadgeState();
}

class _AppBadgeState extends State<AppBadge> {
  List<CartItemModel> cartItems = [];

  @override
  void initState() {
    context.read<CartBloc>().add(FetchCartItemEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context).routerDelegate.currentConfiguration;
    final bool darkMode = AppHelperFunctions.isDarkMode(context);

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartItemLoadedState) {
          cartItems = state.cartItems;
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return IconButton(
              onPressed: () {
                context.pushNamed('cart', extra: cartItems);
              },
              icon: badges.Badge(
                badgeContent: Text(
                  '${cartItems.length}',
                  style: const TextStyle(color: Colors.white),
                ),
                child: Icon(
                  Iconsax.shopping_bag,
                  color: router.fullPath == '/store'
                      ? darkMode
                          ? AppDefineColors.white
                          : AppDefineColors.black
                      : AppDefineColors.white,
                ),
              ));
        },
      ),
    );
  }
}
