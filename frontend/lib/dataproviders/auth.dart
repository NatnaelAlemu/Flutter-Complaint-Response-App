import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;

class AuthDataProvider {
  static Future<User> register(User user) async {
    User currentUser = User("", "");
    print(user.toJson());
    try {
      final httpResponse = await http.post(
        Uri.parse('$API_URL/signup'),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(user.toJson()),
      );
      print("passed");
      print(httpResponse.statusCode);
      if (httpResponse.statusCode == 201) {
        var commingData = jsonDecode(httpResponse.body)['createdUser'];
        currentUser = User.fromJson(commingData);
      }
    } catch (e) {
      print(e.toString());
    }
    return currentUser;
  }

  static Future<dynamic> getAllUsers() async {
    dynamic users;
    try {
      final response = await http.get(Uri.parse("http://API_URL/getall"));
      users = jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
    return users;
  }

  static Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    var finalValue;
    try {
      final httpResponse = await http.post(Uri.parse('$API_URL/login'),
          headers: {
            "accept": "application/json",
            "content-type": "application/json"
          },
          body: json.encode(loginModel.toJson()));
      print("login passed");
      if (httpResponse.statusCode == 200) {
        finalValue = jsonDecode(httpResponse.body);
      }
      if (httpResponse.statusCode == 400) {
        finalValue = jsonDecode(httpResponse.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return finalValue;
  }
}
