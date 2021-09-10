part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}
class SigningUp extends SignUpState{}
class SignedUp extends SignUpState {
  final User signedUser;
  SignedUp({
    required this.signedUser,
  });
  @override
  List<Object?> get props => [signedUser];
}

class SignUpFailed extends SignUpState {
}
