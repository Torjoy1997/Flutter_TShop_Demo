part of 'wish_list_bloc.dart';

sealed class WishListState extends Equatable {
  const WishListState();

  @override
  List<Object> get props => [];
}

final class WishListLoadingState extends WishListState {}

final class WishListLoadedState extends WishListState {
  final List<ProductModel> wishProduct;

  const WishListLoadedState({required this.wishProduct});

  @override
  List<Object> get props => [wishProduct];
}

final class WishListAddState extends WishListState {
  final DateTime timestamp;

  const WishListAddState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class WishListRemoveState extends WishListState {
  final DateTime timestamp;

  const WishListRemoveState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class WishListFavoriteState extends WishListState {
  final List<String> isFavorite;
  final DateTime timeStamp;

  const WishListFavoriteState({
    required this.isFavorite,
    required this.timeStamp,
  });

  @override
  List<Object> get props => [isFavorite];
}

final class WishListError extends WishListState {
  final String errorMessage;
  final String? errorCode;

  const WishListError({required this.errorMessage, this.errorCode});
  @override
  List<Object> get props => [errorMessage];
}
