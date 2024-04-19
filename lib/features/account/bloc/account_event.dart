part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class UserDataFetchEvent extends AccountEvent {}

class UserDataWriteEvent extends AccountEvent {
  final UserModel userData;
  final String uid;
  const UserDataWriteEvent({required this.userData, required this.uid});
}

class UserDataWriteWithGoogleEvent extends AccountEvent{
  final UserCredential user;

 const UserDataWriteWithGoogleEvent({required this.user});
}

class UserDataUpdateEvent extends AccountEvent {
  final UserModel? userData;
  final Map<String,dynamic>? userJson;

  const UserDataUpdateEvent({this.userData, this.userJson});
}

class UserUploadImageEvent extends AccountEvent{
  final String? imageUrl;

  const UserUploadImageEvent({ this.imageUrl});

}

class UserDataRemoveEvent extends AccountEvent {}



