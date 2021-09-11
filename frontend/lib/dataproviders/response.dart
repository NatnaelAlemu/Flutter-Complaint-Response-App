import 'dart:convert';

import 'package:frontend/models/response.dart';
import 'package:frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;

class ResponseDataProvider {
  static Future<dynamic> getAllComplaints() async {
    dynamic message;
    try {
      final response = await http.get(Uri.parse("$API_URL/getallcomplaints"));
      if (response.statusCode == 200) {
        message = jsonDecode(response.body);
      } else {
        message = jsonDecode(response.body)['message'];
      }
    } catch (e) {
      message = {"message": e.toString()};
    }
    return message;
  }
    static Future<dynamic> getFixedComplaints() async {
    dynamic message;
    try {
      final response = await http.get(Uri.parse("$API_URL/getfixedComplaints"));
      if (response.statusCode == 200) {
        message = jsonDecode(response.body);
      } else {
        message = jsonDecode(response.body)['message'];
      }
    } catch (e) {
      message = {"message": e.toString()};
    }
    return message;
  }
  static Future<dynamic> createResponse(Response response) async {
    dynamic message;
    try {
      final result = await http.post(
        Uri.parse('$API_URL/createresponse'),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(response.toJson()),
      );
      if (result.statusCode == 200) {
        message = jsonDecode(result.body);
        print(result);
      } else {
        message = jsonDecode(result.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return message;
  }
    static Future<dynamic> updateResponse(Response response,String id) async {
    dynamic message;
    try {
      final result = await http.put(
        Uri.parse('$API_URL/updateresponse/$id'),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(response.toJson()),
      );
      if (result.statusCode == 201) {
        message = {'update':'update sucess'};
        print(result);
      } else {
        message = jsonDecode(result.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return message;
  }

}
