import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUp) {
      yield SigningUp();
      try {
        User user = await AuthRepository.signUpRepository(event.user);

        print("User ${user.toJson()}");
        if (user.email == '') {
          yield SignUpFailed();
          Future.delayed(Duration(seconds: 3));
          yield SignUpInitial();
        } else {
          yield SignedUp(signedUser: user);
          await Future.delayed(Duration(seconds: 2));
          yield SignUpInitial();
        }
      } catch (e) {
        yield SignUpFailed();
        await Future.delayed(Duration(seconds: 3));
        yield SignUpInitial();
      }
    }
  }
}
