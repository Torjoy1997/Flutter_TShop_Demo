part of 'address_bloc.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class FetchUserAddressLoading extends AddressState {
  final DateTime timestamp;

  const FetchUserAddressLoading({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class FetchUserAddressLoaded extends AddressState {
  final List<AddressModel> userAddress;

  const FetchUserAddressLoaded({required this.userAddress});
  @override
  List<Object> get props => [userAddress];
}

final class AddUserAddressState extends AddressState {
  final DateTime timestamp;

  const AddUserAddressState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class RemoveUserAddressState extends AddressState {
  final DateTime timestamp;

  const RemoveUserAddressState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class SelectTheUserAddress extends AddressState {
  final DateTime timestamp;

  const SelectTheUserAddress({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class ChangePaymentMethodState extends AddressState {
  final DateTime timestamp;

  const ChangePaymentMethodState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class FetchPaymentMethod extends AddressState {
  final PaymentMethodModel paymentData;

  const FetchPaymentMethod({required this.paymentData});

  @override
  List<Object> get props => [paymentData];
}

final class UserAddressError extends AddressState {
  final String errorMessage;
  final String? errorCode;

  const UserAddressError({required this.errorMessage, this.errorCode});

  @override
  List<Object> get props => [errorMessage];
}
