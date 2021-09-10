
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;
class ProfileDataProvider{
  static Future<String> deleteAccount(User user,String token)async{
   var message = "";
   try{
     final httpResponse = await http.delete(
       Uri.parse('$API_URL/deleteaccount/${user.id}')
     );
     if(httpResponse.statusCode == 500){
       message = "internal server error";
     }
     else  message = jsonDecode(httpResponse.body).toString();
     
   }catch(e){
     print(e.toString());
   }
   return message;
 }
  static Future<String> updateAccount(User user,String token)async{
   var message = "";
   try{
     final httpResponse = await http.delete(
       Uri.parse('$API_URL/updateaccount/${user.id}')
     );
     if(httpResponse.statusCode == 500){
       message = "internal server error";
     }
     else  message = jsonDecode(httpResponse.body).toString();
     
   }catch(e){
     print(e.toString());
   }
   return message;
 }

}