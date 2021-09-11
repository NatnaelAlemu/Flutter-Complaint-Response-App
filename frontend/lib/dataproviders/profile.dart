import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;

class ProfileDataProvider {
  static Future<dynamic> updateAccount(User user, String token) async {
    dynamic message;
    try {
      print("from pDp");
      print("user is ${user.toJson()}");
      print("token is ${token}");
      String url = '$API_URL/updateprofile/${user.id}';
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "authorization": 'Bearer $token',
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 201) {
        message = {"updateaccount": "success"};
      } else
        message = response.body;
    } catch (e) {
      message = e.toString();
    }
    return message;
  }

  static Future<dynamic> deleteAccount(User user, String token) async {
    dynamic message;
    try {
      print("from delete pDp");
      print("user is ${user.toJson()}");
      print("token is ${token}");
      String url = '$API_URL/deleteprofile/${user.id}';
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "authorization": 'Bearer $token',
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 200) {
        message = {"deleteaccount": "success"};
      } else
        message = response.body;
    } catch (e) {
      message = e.toString();
    }
    return message;
  }}
