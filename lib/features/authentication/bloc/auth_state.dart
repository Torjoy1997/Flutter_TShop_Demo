part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthUserInitialize extends AuthState {}

final class AuthUserStatus extends AuthState {
  final AuthUser? authUserStatus;

  const AuthUserStatus({this.authUserStatus});
}

final class SignUpInitialize extends AuthState {}

final class SignUpSuccess extends AuthState {
  final String? userName;
  final String email;

  const SignUpSuccess({this.userName, required this.email});
}

final class SignUpFailure extends AuthState {
  final String errorMessage;
  final String? errorCode;
  final String? email;
  const SignUpFailure({this.errorMessage = '', this.errorCode, this.email});
}

final class LoginInitialize extends AuthState {}

final class SignInWithGoogleState extends AuthState {
  final UserCredential user;

  const SignInWithGoogleState({required this.user});
  @override
  List<Object> get props => [user];
}

final class LoginSuccess extends AuthState {
  final User? user;

  const LoginSuccess({this.user});
}

final class LoginFailure extends AuthState {
  final String errorMessage;
  final String? errorCode;
  const LoginFailure({this.errorMessage = '', this.errorCode});
}

final class SendEmailVerificationInitialize extends AuthState {
  final String email;

  const SendEmailVerificationInitialize({required this.email});
}

final class SendEmailVerificationFinished extends AuthState {
  final DateTime timestamp;

  const SendEmailVerificationFinished({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

final class EmailVerificationFailure extends AuthState {
  final String errorMessage;
  final String? errorCode;
  const EmailVerificationFailure({this.errorMessage = '', this.errorCode});
}

final class ForgetPasswordInitialize extends AuthState {}

final class ForgetPasswordSuccess extends AuthState {}

final class ForgetPasswordFailure extends AuthState {
  final String errorMessage;
  final String? errorCode;

  const ForgetPasswordFailure(
      {required this.errorMessage, required this.errorCode});
}

final class LogoutState extends AuthState {}

final class LogoutFail extends AuthState {}
