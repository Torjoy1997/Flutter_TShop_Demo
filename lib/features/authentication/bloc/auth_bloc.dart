import 'package:ecommerce_demo/features/account/bloc/account_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_repository/authentication_repository.dart';
import 'package:ecommerce_demo/features/authentication/model/user.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  final AccountBloc _accountBloc;

  AuthBloc(this._authRepository, this._accountBloc)
      : super(AuthUserInitialize()) {
    on<SignUpEvent>(_onSignUp);
    on<SendEmailVerificationEvent>(_onSendEmailVerification);
    on<AuthStatusChangeEvent>(
        (event, emit) => emit(AuthUserStatus(authUserStatus: event.user)));
    on<LoginEvent>(_onSignIn);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<ForgotPasswordEvent>(_onChangePassword);
    on<LogOutEvent>(_onLogOut);

    _authRepository.user.listen((user) {
      add(AuthStatusChangeEvent(user: user));
    });
  }

  void _onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.signOut();
      emit(LogoutState());
    } catch (e) {
      emit(LogoutFail());
    }
  }

  void _onSignIn(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoginInitialize());
      final userCredential = await _authRepository.signInWithEmailAndPassword(
          event.email, event.password);
      emit(LoginSuccess(user: userCredential.user!));
    } catch (e) {
      emit(LoginFailure(
        errorCode: e.toString(),
        errorMessage: TFirebaseAuthException(e.toString()).message,
      ));
    }
  }

  _onChangePassword(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(ForgetPasswordInitialize());
      await _authRepository.forgotPassword(email: event.email);
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordFailure(
          errorMessage: e.toString(),
          errorCode: TFirebaseAuthException(e.toString()).message));
    }
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SignUpInitialize());
      final userData = event.userModel;
      final userCredential = await _authRepository.registerWithEmailAndPassword(
          userData.email, userData.password ?? '123456Tarek');
      _accountBloc.add(UserDataWriteEvent(
          userData: userData, uid: userCredential.user!.uid));
      emit(SignUpSuccess(email: userData.email));
    } catch (e) {
      emit(SignUpFailure(
          errorCode: e.toString(),
          errorMessage: TFirebaseAuthException(e.toString()).message,
          email: event.userModel.email));
    }
  }

  void _onSendEmailVerification(
      SendEmailVerificationEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SendEmailVerificationInitialize(email: event.email ?? ''));
      await _authRepository.sendMailVerification();
      emit(SendEmailVerificationFinished(timestamp: DateTime.now()));
    } catch (e) {
      emit(EmailVerificationFailure(errorMessage: e.toString()));
    }
  }

  void _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        _accountBloc.add(UserDataWriteWithGoogleEvent(user: user));
        emit(const LoginSuccess());
      }
    } catch (e) {
      emit(EmailVerificationFailure(errorMessage: e.toString()));
    }
  }
}
