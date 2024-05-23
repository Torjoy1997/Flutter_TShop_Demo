part of 'wish_list_bloc.dart';

sealed class WishListEvent extends Equatable {
  const WishListEvent();

  @override
  List<Object> get props => [];
}

class WishListProductEvent extends WishListEvent {}

class WishListAddEvent extends WishListEvent {
  final String productId;

  const WishListAddEvent({
    required this.productId,
  });
  @override
  List<Object> get props => [productId];
}

class WishListRemoveEvent extends WishListEvent {
  final String productId;

  const WishListRemoveEvent({
    required this.productId,
  });
  @override
  List<Object> get props => [productId];
}

class WishListIsFavoriteEvent extends WishListEvent {
  final List<String>? isFavorite;

  const WishListIsFavoriteEvent({this.isFavorite});
}
