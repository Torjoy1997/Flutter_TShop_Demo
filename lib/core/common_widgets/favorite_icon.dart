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
  Map<String, bool> isFavList = {};
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListBloc, WishListState>(
      key: widget.key,
      builder: (context, state) {
        if (state is WishListFavoriteState) {
          isFavList = state.isFavorite;
          isFav = isFavList.isNotEmpty && isFavList[widget.productId] != null;
        }
        return IconContainer(
            iconData: isFav ? Iconsax.heart5 : Iconsax.heart,
            iconColor: isFav ? AppDefineColors.error : null,
            onPressed: isFav
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
