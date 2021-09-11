part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUp extends SignUpEvent {
  final User user;
  SignUp({required this.user});
  @override
  List<Object?> get props => [user];
}


