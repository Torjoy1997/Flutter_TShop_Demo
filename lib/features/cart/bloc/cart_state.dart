part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartItemLoadingState extends CartState {}

final class CartItemLoadedState extends CartState {
  final List<CartItemModel> cartItems;

  const CartItemLoadedState({this.cartItems = const []});

  @override
  List<Object> get props => [cartItems];
}

final class CartProcessLoadingState extends CartState {}

final class CartProcessLoadedState extends CartState {
  final List<CartProcessModel> cartProcess;

  const CartProcessLoadedState({this.cartProcess = const []});

  @override
  List<Object> get props => [cartProcess];
}

final class CartItemAddState extends CartState {
  final DateTime timestamp;

  const CartItemAddState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class CartItemRemoveState extends CartState {
  final DateTime timestamp;

  const CartItemRemoveState({required this.timestamp});
  @override
  List<Object> get props => [timestamp];
}

final class CartItemError extends CartState {
  final String errorMessage;
  final String? errorCode;

  const CartItemError({required this.errorMessage, this.errorCode});
  @override
  List<Object> get props => [errorMessage];
}
