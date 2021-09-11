import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;

class ComplaintDataProvider {
  Future<dynamic> loadAllMyComplaints(String id) async {
    dynamic result;
    try {
      final response = await http.get(
        Uri.parse('$API_URL/getallmycomplaints/$id'),
      );
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404 || response.statusCode == 500) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
    Future<dynamic> loadMyFixedComplaints(String id) async {
    dynamic result;
    try {
      final response = await http.get(
        Uri.parse('$API_URL/getmyfixedComplaints/$id'),
      );
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404 || response.statusCode == 500) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<dynamic> createComplaint(Complaint complaint) async {
    dynamic result;
    try {
      final response = await http.post(
        Uri.parse('$API_URL/createcomplaint'),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(complaint.toJson()),
      );
      if (response.statusCode == 200) {
        result = {"complaint": jsonDecode(response.body)};
        print(result);
      } else {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
    Future<dynamic> updateComplaint(Complaint complaint,String id) async {
    dynamic result;
    try {
      final response = await http.put(
        Uri.parse('$API_URL/updatecomplaint/$id'),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(complaint.toJson()),
      );
      if (response.statusCode == 201) {
        result = {"update": "sucess"};
        print(result);
      } else {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
      Future<dynamic> deleteComplaint(Complaint complaint,String id) async {
    dynamic result;
    try {
      final response = await http.delete(
        Uri.parse('$API_URL/deletecomplaint/$id'),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(complaint.toJson()),
      );
      if (response.statusCode == 200) {
        result = {"delete": "sucess"};
        print(result);
      } else {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

}
