import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frontend/models/loginInModel.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/auth_repository.dart';
import 'package:frontend/repositories/profile_repository.dart';
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
      yield LoginCrudInProgress();
      await Future.delayed(Duration(seconds: 1));
      try {
        Map<String, dynamic> response =
            await AuthRepository.loginRepository(event.loginModel);
        if (response.containsKey('user')) {
          User user = User.fromJson(response['user']);
          String token = response['accessToken'];
          print("user ${user.toJson()}");
          print("token $token");
          yield LoggedIn(user: user, token: token);
        } else {
          yield AuthLoginFailed();
          yield LoginInitial();
        }
      } catch (e) {
        yield AuthLoginFailed();
        yield LoginInitial();
      }
    }
    if (event is UpdateAccount) {
      print("update event is commit");
      yield LoginCrudInProgress();
      try {
        print("user is ${event.user.toJson()}");
        print("token is ${event.token}");
        final result =
            await ProfileRepository.updateProfile(event.user, event.token);
        if (result.containsKey('updateaccount')) {
          yield UpdateAccountSuccess();
        } else {
          yield LoginCrudFailed(result);
        }
      } catch (e) {
        print(e.toString());
      }
    }
    if (event is DeleteAccount) {
      yield LoginCrudInProgress();
      try {
        final result =
            await ProfileRepository.deleteProfile(event.user, event.token);
        if (result.containsKey('deleteaccount')) {
          print("Delete success");
          yield DeleteAccountSuccess();
        } else {
          LoginCrudFailed(result);
        }
      } catch (e) {
        yield LoginCrudFailed(e.toString());
      }
    }
  }
}
