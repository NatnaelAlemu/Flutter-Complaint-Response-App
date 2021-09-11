part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Login extends LoginEvent {
  final LoginModel loginModel;
  Login({
    required this.loginModel,
  });
}

class TrigerInitial extends LoginEvent {}

class UpdateAccount extends LoginEvent {
  final User user;
  final String token;

  UpdateAccount(this.user, this.token);
  List<Object?> get props => [user];
}

class DeleteAccount extends LoginEvent {
  final User user;
  final String token;
  DeleteAccount(this.user, this.token);
  List<Object?> get props => [user];
}
