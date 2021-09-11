part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginCrudInProgress extends LoginState {}

class LoggedIn extends LoginState {
  final User user;
  final String token;
  LoggedIn({
    required this.user,
    required this.token,
  });
}
class AuthLoginFailed extends LoginState{}

class LoginCrudFailed extends LoginState {
  final String message;

  LoginCrudFailed(this.message);
}

class UpdateAccountSuccess extends LoginState {
}
class DeleteAccountSuccess extends LoginState {
}
