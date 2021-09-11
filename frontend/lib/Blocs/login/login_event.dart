part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class Login extends LoginEvent {
  final LoginModel loginModel;
  Login({
    required this.loginModel,
  });


}
class TrigerInitial extends LoginEvent{}