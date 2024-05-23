import 'package:ecommerce_demo/core/layout/icon_container.dart';
import 'package:ecommerce_demo/features/wish_list/bloc/wish_list_bloc.dart';

import 'package:ecommerce_demo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteIcon extends StatefulWidget {
  /// A custom Icon widget which handles its own logic to add or remove products from the Wishlist.
  /// You just have to call this widget on your design and pass a product id.
  ///
  /// It will auto do the logic defined in this widget.
  const FavouriteIcon({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  List<String> wishId = [];

  @override
  void initState() {
    super.initState();
    context.read<WishListBloc>().add(const WishListIsFavoriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListBloc, WishListState>(
      builder: (context, state) {
        if (state is WishListFavoriteState) {
          wishId = state.isFavorite;
        }
        return IconContainer(
            iconData: wishId.isNotEmpty && wishId.contains(widget.productId)
                ? Iconsax.heart5
                : Iconsax.heart,
            iconColor: wishId.isNotEmpty && wishId.contains(widget.productId)
                ? AppDefineColors.error
                : null,
            onPressed: wishId.isNotEmpty && wishId.contains(widget.productId)
                ? () {
                    context.read<WishListBloc>().add(WishListRemoveEvent(
                          productId: widget.productId,
                        ));
                  }
                : () {
                    context
                        .read<WishListBloc>()
                        .add(WishListAddEvent(productId: widget.productId));
                  });
      },
    );
  }
}
