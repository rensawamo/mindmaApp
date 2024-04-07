import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindmapapp/db/session/session.dart';


class EmailVericationViewModel with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? message = '登録したメールアドレスに確認メールを送信しました。\nメール内のリンクをクリックしてください。';
  bool isChecking = false;
  Map<String, String>? data;
  String? email;

  Future<void> sessionSetter() async {
    await SessionController().saveUserEmail(email ?? 'no user email');
    await SessionController().saveUserInPreference(data);
  }


  Future<bool> checkEmailVerified() async {
    isChecking = true;
    // ユーザーが最新の情報に更新されていることを確認
    await _firebaseAuth.currentUser!.reload();
    User? user = _firebaseAuth.currentUser;

    if (user != null && user.emailVerified) {
      return true;
    } else {
      isChecking = false;
      message = 'メールアドレスがまだ確認されていません。\n確認メールのリンクをクリックしてください。';
    }
    return false;
  }

  Future<void> resendEmailVerification() async {
    var user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      message = '確認メールを再送しました。メールをチェックして、リンクをクリックしてください。';
    }
  }
}
