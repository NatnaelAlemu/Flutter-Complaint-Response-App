

import 'package:frontend/dataproviders/auth.dart';
import 'package:frontend/models/models.dart';

class AuthRepository{

  static Future<User> signUpRepository(User user)async{

    return await AuthDataProvider.register(user);
  }
  static Future<Map<String,dynamic>> loginRepository(LoginModel loginModel)async{
    return await AuthDataProvider.login(loginModel);
  }
  static Future<dynamic> getAllUsers()async{
    return await AuthDataProvider.getAllUsers();
  }
  
}