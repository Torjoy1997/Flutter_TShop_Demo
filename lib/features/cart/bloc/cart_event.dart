part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartItemEvent extends CartEvent {}

class ProcessCartItemEvent extends CartEvent {
  final List<CartProcessModel> cartProcess;

  const ProcessCartItemEvent({required this.cartProcess});
}

class CartItemAddEvent extends CartEvent {
  final Map<String, dynamic> cartItem;

  const CartItemAddEvent({
    required this.cartItem,
  });
}

class CartItemRemoveEvent extends CartEvent {
  final String cartId;

  const CartItemRemoveEvent({required this.cartId});
  @override
  List<Object> get props => [cartId];
}
