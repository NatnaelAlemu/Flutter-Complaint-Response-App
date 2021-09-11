import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frontend/models/response.dart';
import 'package:frontend/repositories/response.dart';
import 'package:meta/meta.dart';

part 'response_event.dart';
part 'response_state.dart';

class ResponseBloc extends Bloc<ResponseEvent, ResponseState> {
  ResponseBloc() : super(ResponseInitial());

  @override
  Stream<ResponseState> mapEventToState(
    ResponseEvent event,
  ) async* {
    if (event is TriggerIntial) {
      print("Trigger event is called");
      yield ResponseInitial();
    }
    if (event is GetAllComplaints) {
      yield ResponseCrudInProgress();
      try {
        var result = await ResponseRepository.getAllComplaints();
        if (result.containsKey('allcomplaints')) {
          yield AllComplaintsLoaded(result['allcomplaints']);
        } else {
          yield ResponseCrudFailed(result['message']);
        }
      } catch (e) {
        yield ResponseCrudFailed(e.toString());
      }
    }
    if (event is GetFixedComplaints) {
      yield ResponseCrudInProgress();
      try {
        var result = await ResponseRepository.getFixedComplaints();
        if (result.containsKey('allcomplaints')) {
          yield FixedComplaintsLoaded(result['allcomplaints']);
        } else {
          yield ResponseCrudFailed(result['message']);
        }
      } catch (e) {
        yield ResponseCrudFailed(e.toString());
      }
    }
    if (event is CreateResponse) {
      yield ResponseCrudInProgress();
      try {
        var result = await ResponseRepository.createResponse(event.response);
        if (result.containsKey('response')) {
          yield ResponseCrudSucess("Response Submitted Successfully");
        } else {
          yield ResponseCrudFailed(result['message']);
        }
      } catch (e) {
        yield ResponseCrudFailed(e.toString());
      }
    }
    if (event is UpdateResponse) {
      yield ResponseCrudInProgress();
      try {
        var result = await ResponseRepository.updateResponse(
            event.response, event.response.id!);
        if (result.containsKey('update')) {
          yield ResponseCrudSucess("Response updated Successfully");
        } else {
          yield ResponseCrudFailed(result['message']);
        }
      } catch (e) {
        yield ResponseCrudFailed(e.toString());
      }
    }
  }
}
