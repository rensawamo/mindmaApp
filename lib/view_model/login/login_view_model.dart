import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class LoginViewModel with ChangeNotifier {
  
  bool _loginLoading = false; // ぐるぐる
  bool get loginLoading => _loginLoading;
  bool isLogin = false;

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
}
