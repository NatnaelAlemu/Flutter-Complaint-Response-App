

import 'package:frontend/dataproviders/profile.dart';
import 'package:frontend/models/models.dart';

class ProfileRepository{

  static Future<dynamic> updateProfile(User user,String token)async{
    return await ProfileDataProvider.updateAccount(user, token);
  }
    static Future<dynamic> deleteProfile(User user,String token)async{
    return await ProfileDataProvider.deleteAccount(user, token);
  }
}