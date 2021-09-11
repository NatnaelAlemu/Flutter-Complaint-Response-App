import 'package:frontend/dataproviders/response.dart';
import 'package:frontend/models/response.dart';

class ResponseRepository {
  static Future<dynamic> getAllComplaints() async {
    return await ResponseDataProvider.getAllComplaints();
  }
  static Future<dynamic> getFixedComplaints() async {
    return await ResponseDataProvider.getFixedComplaints();
  }

  static Future<dynamic> createResponse(Response response) async {
    return ResponseDataProvider.createResponse(response);
  }
    static Future<dynamic> updateResponse(Response response,String id) async {
    return ResponseDataProvider.updateResponse(response,id);
  }
  
}
