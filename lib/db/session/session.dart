import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mindmapapp/model/user_model/user_model.dart';
import 'package:mindmapapp/db/strage/local_storage.dart';

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
    isLogin = false;
  }

  // email をlocalに保存
  // settingのview用
  Future<void> saveUserEmail(String email) async {
    sharedPreferenceClass.setValue('email', email);
  }

  // email をlocalから取得
  Future<void> sessionClear() async {
    sharedPreferenceClass.clearValue('token');
    sharedPreferenceClass.clearValue('isLogin');
    isLogin = false;
  }

  //  token 情報の保存
  Future<void> saveUserInPreference(user) async {
    sharedPreferenceClass.setValue('token', jsonEncode(user));
    //storing value to check login
    sharedPreferenceClass.setValue('isLogin', 'true');
  }

  //  ユーザ情報を取得
  Future<void> getUserFromPreference() async {
    try {
      var userData = await sharedPreferenceClass.readValue('token');
      var isLogin = await sharedPreferenceClass.readValue('isLogin');
      if (userData.isNotEmpty) {
        SessionController().user = UserModel.fromJson(jsonDecode(userData));
      }
      SessionController().isLogin = isLogin == 'true' ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
