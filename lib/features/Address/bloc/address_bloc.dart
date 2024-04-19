import 'dart:async';

import 'package:ecommerce_demo/features/Address/repos/address.dart';
import 'package:ecommerce_demo/features/cart/model/payment_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/address.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;
  late StreamSubscription addressStreamSub;
  late StreamSubscription paymentSubscription;
  AddressBloc({required this.addressRepository}) : super(AddressInitial()) {
    addressStreamSub = addressRepository.fetchStreamUserAddress().listen(
      (userAddress) {
        add(FetchUserAddressEvent(userAddress: userAddress));
      },
    );

    paymentSubscription = addressRepository.changePaymentMethod().listen(
      (paymentData) {
        add(FetchPaymentEvent(paymentMethodData: paymentData));
      },
    );

    on<FetchUserAddressEvent>((event, emit) async {
      try {
        if (event.userAddress.isEmpty) {
          emit(FetchUserAddressLoading(timestamp: DateTime.now()));
          final userAddress = await addressRepository.fetchUserAddress();
          emit(FetchUserAddressLoaded(userAddress: userAddress));
        } else {
          emit(FetchUserAddressLoaded(userAddress: event.userAddress));
        }
      } catch (e) {
        emit(UserAddressError(errorMessage: e.toString()));
      }
    });

    on<AddUserAddressEvent>((event, emit) async {
      try {
        await addressRepository.addUserAddress();
        emit(AddUserAddressState(timestamp: DateTime.now()));
      } catch (e) {
        emit(UserAddressError(errorMessage: e.toString()));
      }
    });

    on<RemoveUserAddressEvent>((event, emit) async {
      try {
        await addressRepository.removeUserAddress(event.userAddressId);
        emit(RemoveUserAddressState(timestamp: DateTime.now()));
      } catch (e) {
        emit(UserAddressError(errorMessage: e.toString()));
      }
    });

    on<SelectTheUserAddressEvet>((event, emit) async {
      try {
        await addressRepository.changeTheAddress(event.userAddressId);
        emit(SelectTheUserAddress(timestamp: DateTime.now()));
      } catch (e) {
        emit(UserAddressError(errorMessage: e.toString()));
      }
    });

    on<ChangePaymentMethod>((event, emit) async {
      try {
        await addressRepository.addPaymentMethod(
          paymentData: event.paymentMethod,
        );
        emit(ChangePaymentMethodState(timestamp: DateTime.now()));
      } catch (e) {
        emit(UserAddressError(errorMessage: e.toString()));
      }
    });

    on<FetchPaymentEvent>((event, emit) async {
      try {
        if (event.paymentMethodData == null) {
          final paymentData = await addressRepository.getPaymentMethod();
          emit(FetchPaymentMethod(paymentData: paymentData));
        } else {
          emit(FetchPaymentMethod(paymentData: event.paymentMethodData!));
        }
      } catch (e) {
        emit(UserAddressError(errorMessage: e.toString()));
      }
    });
  }

  @override
  Future<void> close() {
    addressStreamSub.cancel();
    paymentSubscription.cancel();
    return super.close();
  }
}
