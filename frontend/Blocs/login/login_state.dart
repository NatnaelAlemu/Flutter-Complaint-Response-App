part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoggingIn extends LoginState{

}
class LoggedIn extends LoginState {
  final User user;
  final String token;
  LoggedIn({
    required this.user,
    required this.token,
  });
}
class LoginFailed extends LoginState{

}
