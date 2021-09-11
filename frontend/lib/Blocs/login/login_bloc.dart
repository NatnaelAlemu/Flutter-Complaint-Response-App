import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frontend/models/loginInModel.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is TrigerInitial) {
      yield LoginInitial();
    }
    if (event is Login) {
      yield LoggingIn();
      await Future.delayed(Duration(seconds: 1));
      try {
        Map<String, dynamic> response =
            await AuthRepository.loginRepository(event.loginModel);
        if (response.containsKey('user')) {
          User user = User.fromJson(response['user']);
          String token = response['accessToken'];
          yield LoggedIn(user: user, token: token);
        } else {
          yield LoginFailed();
          yield LoginInitial();
        }
      } catch (e) {
        yield LoginFailed();
        yield LoginInitial();
      }
    }
  }
}
