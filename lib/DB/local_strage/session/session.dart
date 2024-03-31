import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../model/user_model/user_model.dart';
import '../strage/strage.dart';

//singleton class
class SessionController {

  LocalStorage sharedPreferenceClass = LocalStorage();
  static final SessionController _session = SessionController._internel();

  bool? isLogin;
  UserModel user = UserModel();
  String? email;

  factory SessionController() {
    return _session;
  }

  SessionController._internel() {
    // here we can initialize the values
    isLogin = false;
  }

  // email をlocalに保存
  // settingのview用
  Future<void> saveUserEmail(String email) async {
    sharedPreferenceClass.setValue('email', email);
  }

  // saving data into shared preference
  Future<void> saveUserInPreference(dynamic user) async {
    sharedPreferenceClass.setValue('token', jsonEncode(user));
    //storing value to check login
    sharedPreferenceClass.setValue('isLogin', 'true');
  }

  //getting User Data from shared Preference
  // and assigning it to session controller to used it across the app
  Future<void> getUserFromPreference() async {
    try {
      var userData = await sharedPreferenceClass.readValue('token');
      var isLogin = await sharedPreferenceClass.readValue('isLogin');
      if (userData.isNotEmpty) {
        SessionController().user = UserModel.fromJson(jsonDecode(userData));
      }
      SessionController().isLogin = isLogin == 'true'  ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
