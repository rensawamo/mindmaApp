import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessage; // firebaseのエラーメッセージ
  bool _loginLoading = false; // ぐるぐる
  bool get loginLoading => _loginLoading;
  bool isLogin = false; // ログインかサインアップか

  void setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;

  void setEmail(String email) {
    _email = email;
  }

  void setIsLogin() {
    if (isLogin == true) {
      isLogin = false;
    } else {
      isLogin = true;
    }
    notifyListeners();
  }

  String _password = '';
  String get password => _password;

  void setPassword(String password) {
    _password = password;
  }

  // userが入力した email が確認されているかどうか
  Future<bool> checkEmailVerified() async {
    // まだfirebaseの認証をしていない場合
    if (_firebaseAuth.currentUser == null) {
      return false;
    }
    await _firebaseAuth.currentUser!.reload();
    User? user = _firebaseAuth.currentUser;
    print(user);
    if (user == null) {
      return false;
    } else if (user.emailVerified) {
      return true;
    } else {
      return false;
    }
  }
}
