import 'dart:async';

import 'package:ecommerce_demo/features/product/repos/product.dart';
import 'package:ecommerce_demo/features/store/model/brand.dart';

import 'package:ecommerce_demo/features/cart/model/cart_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../model/cart_process.dart';
import '../repos/cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  final ProductRepository _productRepository;
  late StreamSubscription cartSubscription;
  CartBloc(this._cartRepository, this._productRepository)
      : super(CartInitial()) {
    cartSubscription = _cartRepository.fetchStreamCartItem().listen(
      (cartItems) {
        add(ProcessCartItemEvent(cartProcess: cartItems));
      },
    );

    on<FetchCartItemEvent>((event, emit) async {
      try {
        emit(CartItemLoadingState());
        final cartItems = await _cartRepository.fetchCartItem();

        add(ProcessCartItemEvent(cartProcess: cartItems ?? []));
      } catch (e) {
        emit(CartItemError(errorMessage: e.toString()));
      }
    });

    on<ProcessCartItemEvent>((event, emit) async {
      try {
        if (event.cartProcess.isNotEmpty) {
          final List<CartItemModel> cartData = [];
          for (var cartProcess in event.cartProcess) {
            final result =
                await _productRepository.getTheProduct(cartProcess.prductID);
            cartData.add(CartItemModel(
                id: cartProcess.id,
                quantity: cartProcess.quantity,
                title: result.title,
                brandData:
                    result.brand != null ? result.brand! : BrandModel.empty(),
                image: cartProcess.selectedVariation.isNotEmpty
                    ? cartProcess.selectedVariation['image']
                    : result.thumbnail,
                price: cartProcess.selectedVariation.isNotEmpty
                    ? cartProcess.selectedVariation['price'].toDouble() *
                        cartProcess.quantity
                    : result.price.toDouble() * cartProcess.quantity,
                selectedVariation: cartProcess.selectedVariation));
          }
          emit(CartItemLoadedState(cartItems: cartData));
        } else {
          emit(const CartItemLoadedState(cartItems: []));
        }
      } catch (e) {
        emit(CartItemError(errorMessage: e.toString()));
      }
    });

    on<CartItemAddEvent>((event, emit) async {
      try {
        await _cartRepository.cartAddItems(event.cartItem);
        emit(CartItemAddState(timestamp: DateTime.now()));
      } catch (e) {
        emit(CartItemError(errorMessage: e.toString()));
      }
    });

    on<CartItemRemoveEvent>((event, emit) async {
      try {
        await _cartRepository.cartItemRemove(event.cartId);
        emit(CartItemRemoveState(timestamp: DateTime.now()));
      } catch (e) {
        emit(CartItemError(errorMessage: e.toString()));
      }
    });
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    return CartItemLoadedState(cartItems: json['cartData']);
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    if (state is CartItemLoadedState) {
      return {'cartData': state.cartItems};
    } else {
      return null;
    }
  }
}
