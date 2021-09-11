import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/complaint.dart';
import 'package:meta/meta.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc({required this.repository}) : super(ComplaintInitial());
  final ComplaintRepository repository;

  @override
  Stream<ComplaintState> mapEventToState(
    ComplaintEvent event,
  ) async* {
    if (event is LoadAllMyComplaints) {
      yield ComplaintsLoading();
      try {
        var result = await repository.loadAllMyComplaints(event.id);
        if (result.containsKey('mycomplaints')) {
          print('success');
          yield AllMyComplaintsLoaded(result['mycomplaints']);
        } else if (result.containsKey('message')) {
          yield FailedComplaintsCrud(result['message']);
        }
      } catch (e) {
        yield FailedComplaintsCrud("Server Error");
      }
    } else if (event is LoadFixedComplaints) {
      yield ComplaintsLoading();
      try {
        var result = await repository.loadMyFixedComplaints(event.id);
        if (result.containsKey('myfixedcomplaints')) {
          yield AllMyFixedComplaintsLoaded(result['myfixedcomplaints']);
        }if (result.containsKey('message')) {
          yield FailedComplaintsCrud(result['message']);
        }
      } catch (e) {
          print("fixed sucess");

        yield FailedComplaintsCrud("Server Error");
      }
    } else if (event is CreateComplaint) {
      yield ComplaintsLoading();
      await Future.delayed(
        Duration(seconds: 3),
      );
      try {
        var message = await repository.createCompliant(event.complaint);
        if (message.containsKey("complaint")) {
          yield ComplaintCrudOperationsSuccess("Complaint created successfully");
        } else if (message.containsKey("message")) {
          yield FailedComplaintsCrud(message['message']);
        }
      } catch (e) {
        print(e.toString());
      }
    }
    else if (event is UpdateComplaint) {
      yield ComplaintsLoading();
      await Future.delayed(
        Duration(seconds: 3),
      );
      try {
        var message = await repository.updateComplaint(event.complaint,event.complaint.id!);
        if (message.containsKey("update")) {
          yield ComplaintCrudOperationsSuccess("Complaint Upadated successfully");
        } else
          yield FailedComplaintsCrud(message['message']);
        
      } catch (e) {
          yield FailedComplaintsCrud(e.toString());
      }
    }
    else if (event is DeleteComplaint) {
      yield ComplaintsLoading();
      await Future.delayed(
        Duration(seconds: 3),
      );
      try {
        var message = await repository.deleteComplaint(event.complaint,event.complaint.id!);
        if (message.containsKey("delete")) {
          yield ComplaintCrudOperationsSuccess("Complaint Deleted successfully");
        } else
          yield FailedComplaintsCrud(message['message']);
        
      } catch (e) {
          yield FailedComplaintsCrud(e.toString());
      }
    }
  }
}
