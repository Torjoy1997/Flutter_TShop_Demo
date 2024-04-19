part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderFetchLoadingState extends OrderState {
  final DateTime timestamp;

  const OrderFetchLoadingState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class OrederFetchLoadedState extends OrderState {
  final List<OrderModel> orderData;

  const OrederFetchLoadedState({required this.orderData});

  @override
  List<Object> get props => [orderData];
}

final class AddOrdersItem extends OrderState {
  final DateTime timestamp;

  const AddOrdersItem({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class OrderItemError extends OrderState {
  final String errorMessage;
  final String? errorCode;

  const OrderItemError({required this.errorMessage, this.errorCode});
  @override
  List<Object> get props => [errorMessage];
}
