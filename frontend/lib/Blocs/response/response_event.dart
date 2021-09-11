part of 'response_bloc.dart';

@immutable
abstract class ResponseEvent {}
class TriggerIntial extends ResponseEvent{}
class GetAllComplaints extends ResponseEvent {}
class GetFixedComplaints extends ResponseEvent {}

class CreateResponse extends ResponseEvent {
  final Response response;

  CreateResponse(this.response);
}

class UpdateResponse extends ResponseEvent {
  final Response response;

  UpdateResponse(this.response);
}
