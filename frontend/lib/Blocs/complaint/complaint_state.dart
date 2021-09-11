part of 'complaint_bloc.dart';

@immutable
abstract class ComplaintState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ComplaintInitial extends ComplaintState {}

class AllMyComplaintsLoaded extends ComplaintState {
  final List<dynamic> allmycomplaints;

  AllMyComplaintsLoaded(this.allmycomplaints);
  @override
  List<Object?> get props => [allmycomplaints];
}
class AllMyFixedComplaintsLoaded extends ComplaintState {
  final List<dynamic> allmyfixedcomplaints;

  AllMyFixedComplaintsLoaded(this.allmyfixedcomplaints);
  @override
  List<Object?> get props => [allmyfixedcomplaints];
}

class FailedComplaintsCrud extends ComplaintState {
  final String message;

  FailedComplaintsCrud(this.message);
}

class ComplaintsLoading extends ComplaintState {}

class ComplaintCrudOperationsSuccess extends ComplaintState {
  final String message;

  ComplaintCrudOperationsSuccess(this.message);

}
