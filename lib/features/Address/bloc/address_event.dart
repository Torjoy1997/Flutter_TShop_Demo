// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class FetchUserAddressEvent extends AddressEvent {
  final List<AddressModel> userAddress;
  const FetchUserAddressEvent({
    this.userAddress = const [],
  });
}

class AddUserAddressEvent extends AddressEvent {}

class SelectTheUserAddressEvet extends AddressEvent {
  final String userAddressId;
  const SelectTheUserAddressEvet({required this.userAddressId});
  @override
  List<Object> get props => [userAddressId];
}

class RemoveUserAddressEvent extends AddressEvent {
  final String userAddressId;
  const RemoveUserAddressEvent({required this.userAddressId});
  @override
  List<Object> get props => [userAddressId];
}

class FetchPaymentEvent extends AddressEvent {
  final PaymentMethodModel? paymentMethodData;

  const FetchPaymentEvent({this.paymentMethodData});
}

class ChangePaymentMethod extends AddressEvent {
  final PaymentMethodModel paymentMethod;


  const ChangePaymentMethod({
    required this.paymentMethod,

  });
}
