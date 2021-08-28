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
    if(event is SignUp){
      yield SigningUp();
      var user = await AuthRepository.getAllUsers();
      print("all users ${user.toString()}");
      try{
        User user = await AuthRepository.signUpRepository(event.user);
        print("User $user");
        if(user.email == ''){
          yield SignUpFailed();
        }else{
          yield SignedUp(signedUser: user);
        }
        
      }catch(e){
        yield SignUpFailed();
      }

    }
  }
}
