part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

final class UserDataFetchLoading extends AccountState {}

final class UserDataFetchSuccess extends AccountState {
  final UserModel userData;

  const UserDataFetchSuccess({required this.userData});
}

final class UserDataFetchFailure extends AccountState {
  final String errorMessage;
  final String? errorCode;

  const UserDataFetchFailure({required this.errorMessage, this.errorCode});
}

final class UserDataWriteSuccess extends AccountState {}

final class UserDataWriteFailure extends AccountState {
  final String errorMessage;
  final String? errorCode;

  const UserDataWriteFailure({required this.errorMessage, this.errorCode});
}

final class UserDataUpdateLoading extends AccountState{}

final class UserDataUpdateSuccess extends AccountState{}

final class UserUploadImageLoading extends AccountState{}

final class UserUploadImageSuccess extends AccountState{}

final class UserDataUpdateFailure extends AccountState{
  final String errorMessage;
  final String? errorCode;

  const UserDataUpdateFailure({required this.errorMessage,  this.errorCode});
}

final class LoadDataIn extends AccountState{}

final class LoadDataFinish extends AccountState{}
