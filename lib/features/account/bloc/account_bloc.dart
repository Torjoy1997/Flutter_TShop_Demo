import 'package:ecommerce_demo/features/account/repos/account_repos.dart';
import 'package:ecommerce_demo/features/authentication/model/user.dart';
import 'package:ecommerce_demo/utils/exceptions/firebase_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc(this._accountRepository) : super(AccountInitial()) {
    on<UserDataFetchEvent>(_onUserFetchingData);
    on<UserDataWriteEvent>(_onUserDataSave);
    on<UserDataWriteWithGoogleEvent>(_onUserDataSaveWithGoogle);
    on<UserDataUpdateEvent>(_onUserDataUpdate);
    on<UserUploadImageEvent>(_onUserUploadImage);
  }

  void _onUserFetchingData(
      UserDataFetchEvent event, Emitter<AccountState> emit) async {
    try {
      emit(UserDataFetchLoading());
      final userData = await _accountRepository.fetchUser();
      emit(UserDataFetchSuccess(userData: userData));
    } catch (e) {
      emit(UserDataFetchFailure(errorMessage: e.toString()));
    }
  }

  void _onUserDataSave(
      UserDataWriteEvent event, Emitter<AccountState> emit) async {
    try {
      final userData = event.userData;
      await _accountRepository.saveUserRecord(
          UserModel(
              firstName: userData.firstName,
              lastName: userData.lastName,
              email: userData.email,
              phoneNumber: userData.phoneNumber,
              profilePic: userData.profilePic),
          event.uid);
      emit(UserDataWriteSuccess());
    } catch (e) {
      emit(UserDataWriteFailure(
          errorMessage: TFirebaseException(e.toString()).message));
    }
  }

  void _onUserDataSaveWithGoogle(UserDataWriteWithGoogleEvent event, Emitter<AccountState> emit)async{
    try {
      await _accountRepository.saveUserRecordWithGoogle(event.user);
      emit(UserDataWriteSuccess());
    } catch (e) {
      emit(UserDataWriteFailure(
          errorMessage: TFirebaseException(e.toString()).message));
    }
  }

  void _onUserDataUpdate(
      UserDataUpdateEvent event, Emitter<AccountState> emit) async {
    try {
      if (event.userData != null) {
        emit(UserDataUpdateLoading());
        await _accountRepository.updateUserDetails(event.userData!);
        emit(UserDataUpdateSuccess());
      } else {
        emit(UserDataUpdateLoading());
        await _accountRepository.updateUserSingleField(event.userJson!);
        emit(UserDataUpdateSuccess());
      }
    } catch (e) {
      emit(UserDataUpdateFailure(
          errorMessage: TFirebaseException(e.toString()).message));
    }
  }

  void _onUserUploadImage(
      UserUploadImageEvent event, Emitter<AccountState> emit) async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        emit(UserUploadImageLoading());
        final imageUrl = await _accountRepository.uploadImage(
            'Users/images/profile', image, event.imageUrl ?? '');
        add(UserDataUpdateEvent(userJson: {'profilePic': imageUrl}));
        emit(UserUploadImageSuccess());
      }
    } catch (e) {
      emit(UserDataUpdateFailure(
          errorMessage: TFirebaseException(e.toString()).message));
    }
  }
}
