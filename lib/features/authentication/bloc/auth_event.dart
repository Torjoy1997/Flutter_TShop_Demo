part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusChangeEvent extends AuthEvent {
  final AuthUser? user;

  const AuthStatusChangeEvent({this.user});
}

class SignUpEvent extends AuthEvent {
  final UserModel userModel;
  const SignUpEvent(this.userModel);
}

class SignInWithGoogleEvent extends AuthEvent{}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class LogOutEvent extends AuthEvent {}

class SendEmailVerificationEvent extends AuthEvent {
  final String? email;

  const SendEmailVerificationEvent({this.email});
}

class CheckEmailVerificationEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});
}


