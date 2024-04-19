import 'package:ecommerce_demo/features/wish_list/repos/wish_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../product/model/product.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  final WishListRepository _wishListRepository;
  WishListBloc(this._wishListRepository)
      : super(const WishListFavoriteState()) {
    on<WishListIsFavoriteEvent>((event, emit) async {
      try {
        final Map<String, bool> isFav =
            await _wishListRepository.isFavoriteList();

        emit(WishListFavoriteState(isFavorite: isFav));
      } catch (e) {
        emit(WishListError(errorMessage: e.toString()));
      }
    });

    on<WishListProductEvent>((event, emit) async {
      try {
        emit(WishListLoadingState());
        final wishProducts = await _wishListRepository.getWishProduct();
        emit(WishListLoadedState(wishProduct: wishProducts ?? []));
      } catch (e) {
        emit(WishListError(errorMessage: e.toString()));
      }
    });

    on<WishListAddEvent>((event, emit) async {
      try {
        await _wishListRepository.addWish(event.productId);
        add(WishListIsFavoriteEvent());
        emit(WishListAddState(timestamp: DateTime.now()));
      } catch (e) {
        emit(WishListError(errorMessage: e.toString()));
      }
    });

    on<WishListRemoveEvent>((event, emit) async {
      try {
        await _wishListRepository.removeWish(event.productId);
        add(WishListIsFavoriteEvent());
        emit(WishListRemoveState(timestamp: DateTime.now()));
      } catch (e) {
        emit(WishListError(errorMessage: e.toString()));
      }
    });
  }
}
