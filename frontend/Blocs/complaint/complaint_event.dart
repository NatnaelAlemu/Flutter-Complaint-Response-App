part of 'complaint_bloc.dart';

@immutable
abstract class ComplaintEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllMyComplaints extends ComplaintEvent {
  final String id;

  LoadAllMyComplaints(this.id);
}

class LoadFixedComplaints extends ComplaintEvent {
  final String id;
  LoadFixedComplaints(this.id);
}

class CreateComplaint extends ComplaintEvent {
  final Complaint complaint;

  CreateComplaint(this.complaint);
}

class UpdateComplaint extends ComplaintEvent {
  final Complaint complaint;

  UpdateComplaint(this.complaint);
}

class DeleteComplaint extends ComplaintEvent {
  final Complaint complaint;

  DeleteComplaint(this.complaint);
}
