part of 'response_bloc.dart';

@immutable
abstract class ResponseState {}

class ResponseInitial extends ResponseState {}

class ResponseCrudInProgress extends ResponseState {}

class ResponseCrudSucess extends ResponseState {
  final dynamic message;

  ResponseCrudSucess(this.message);
}

class AllComplaintsLoaded extends ResponseState {
  final List<dynamic> allcomplaints;

  AllComplaintsLoaded(this.allcomplaints);
}
class FixedComplaintsLoaded extends ResponseState {
  final List<dynamic> fixedcomplaints;

  FixedComplaintsLoaded(this.fixedcomplaints);
}

class ResponseCrudFailed extends ResponseState {
  final String message;

  ResponseCrudFailed(this.message);
}
