

import 'package:frontend/dataproviders/profile.dart';
import 'package:frontend/models/models.dart';

class ProfileRepository{

  static Future<String> updateProfile(User user,String token)async{
    return await ProfileDataProvider.updateAccount(user, token);
  }
    static Future<String> deleteProfile(User user,String token)async{
    return await ProfileDataProvider.deleteAccount(user, token);
  }
}