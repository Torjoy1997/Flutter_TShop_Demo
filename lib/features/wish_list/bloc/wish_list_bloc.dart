import 'dart:async';

import 'package:ecommerce_demo/features/wish_list/repos/wish_list.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../product/model/product.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends HydratedBloc<WishListEvent, WishListState> {
  final WishListRepository _wishListRepository;
  late StreamSubscription wishSubscription;
  WishListBloc(this._wishListRepository) : super(WishListLoadingState()) {
    wishSubscription =
        _wishListRepository.isFavoriteListStrem().listen((favListID) {
      add(WishListIsFavoriteEvent(isFavorite: favListID));
    });

    on<WishListIsFavoriteEvent>((event, emit) async {
      try {
        if (event.isFavorite != null) {
          emit(WishListFavoriteState(
              isFavorite: event.isFavorite!, timeStamp: DateTime.now()));
        } else {
          final isFav = await _wishListRepository.isFavoriteList();

          emit(WishListFavoriteState(
              isFavorite: isFav, timeStamp: DateTime.now()));
        }
      } catch (e) {
        emit(WishListError(errorMessage: e.toString()));
      }
    });

    on<WishListProductEvent>((event, emit) async {
      try {
        emit(WishListLoadingState());
        final wishProducts = await _wishListRepository.getWishProduct();

        emit(WishListLoadedState(wishProduct: wishProducts));
      } catch (e) {
        emit(WishListError(errorMessage: e.toString()));
      }
    });

    on<WishListAddEvent>((event, emit) async {
      try {
        await _wishListRepository.addWish(event.productId);
        emit(WishListAddState(timestamp: DateTime.now()));
      } catch (e) {
        emit(WishListError(errorMessage: e.toString()));
      }
    });

    on<WishListRemoveEvent>((event, emit) async {
      try {
        await _wishListRepository.removeWish(event.productId);

        emit(WishListRemoveState(timestamp: DateTime.now()));
      } catch (e) {
        emit(WishListError(errorMessage: e.toString()));
      }
    });
  }

  @override
  WishListState? fromJson(Map<String, dynamic> json) {
    return WishListFavoriteState(
        isFavorite: json['FavoriteList'], timeStamp: DateTime.now());
  }

  @override
  Map<String, dynamic>? toJson(WishListState state) {
    if (state is WishListFavoriteState) {
      return {'FavoriteList': state.isFavorite};
    } else {
      return null;
    }
  }
}
