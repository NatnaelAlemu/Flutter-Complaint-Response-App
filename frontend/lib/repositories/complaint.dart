import 'package:frontend/dataproviders/complaint.dart';
import 'package:frontend/models/models.dart';

class ComplaintRepository {
  final ComplaintDataProvider complaintDataProvider;

  ComplaintRepository({required this.complaintDataProvider});

  Future<dynamic> loadAllMyComplaints(String id) async {
    return complaintDataProvider.loadAllMyComplaints(id);
  }
  Future<dynamic> createCompliant(Complaint complaint)async{
    return await complaintDataProvider.createComplaint(complaint);
  }
    Future<dynamic> loadMyFixedComplaints(String id)async{
    return await complaintDataProvider.loadMyFixedComplaints(id);
  }
  Future<dynamic> updateComplaint(Complaint complaint, String id)async{
    return await complaintDataProvider.updateComplaint(complaint, id);
  }
    Future<dynamic> deleteComplaint(Complaint complaint, String id)async{
    return await complaintDataProvider.deleteComplaint(complaint, id);
  }
}
