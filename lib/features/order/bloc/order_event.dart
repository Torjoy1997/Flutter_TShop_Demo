part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class FetchOrderEvent extends OrderEvent {}

class AddOrderEvent extends OrderEvent {
  final OrderModel orderData;

  const AddOrderEvent({required this.orderData});
}
