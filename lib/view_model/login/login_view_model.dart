import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class LoginViewModel with ChangeNotifier {

  //  changeNotifierによる loading
  bool _loginLoading = false ;
  bool get loginLoading => _loginLoading ;
  bool isLogin = false ;

  setLoginLoading(bool value){
    _loginLoading = value;
    notifyListeners();
  }

  //creating getter method to store value of input email
  String _email = '' ;
  String get email => _email ;

  setEmail(String email){
    _email = email ;
  }
  setIsLogin() {
    if (isLogin == true) {
      isLogin = false;
    } else {
      isLogin = true;
    }
    notifyListeners();
  }

  //creating getter method to store value of input password
  String _password = '' ;
  String get password => _password ;

  setPassword(String password){
    _password = password ;
  }
}

