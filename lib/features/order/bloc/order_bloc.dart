import 'package:ecommerce_demo/features/cart/repos/cart.dart';
import 'package:ecommerce_demo/features/order/repos/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  final CartRepository _cartRepository;
  OrderBloc(this._orderRepository, this._cartRepository)
      : super(OrderInitial()) {
    on<FetchOrderEvent>((event, emit) async {
      try {
        emit(OrderFetchLoadingState(timestamp: DateTime.now()));
        final orderData = await _orderRepository.fetchUserOrders();
        emit(OrederFetchLoadedState(orderData: orderData ?? []));
      } catch (e) {
        emit(OrderItemError(errorMessage: e.toString()));
      }
    });

    on<AddOrderEvent>((event, emit) async {
      try {
        await _orderRepository.saveTheUserOrder(event.orderData);
        emit(AddOrdersItem(timestamp: DateTime.now()));
        await _cartRepository.allCartItemRemove();
      } catch (e) {
        emit(OrderItemError(errorMessage: e.toString()));
      }
    });
  }
}
