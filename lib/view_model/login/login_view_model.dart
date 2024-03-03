import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


import '../../model/user_model.dart';
import '../../repository/login_api/auth_repository.dart';
import '../local_strage/session/session.dart';


class LoginViewModel with ChangeNotifier {

  AuthRepository authRepository ;
  LoginViewModel({required this.authRepository});

  //  changeNotifierによる loading
  bool _loginLoading = false ;
  bool get loginLoading => _loginLoading ;

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

  //creating getter method to store value of input password
  String _password = '' ;
  String get password => _password ;

  setPassword(String password){
    _password = password ;
  }

  Future<UserModel> loginApi(dynamic data) async {

    try {
      setLoginLoading(true);
      final response = await authRepository.loginApi(data);
      await SessionController().saveUserInPreference(response);
      await SessionController().getUserFromPreference();
      setLoginLoading(false);
      return response ;
    }catch(e){
      setLoginLoading(false);
      throw Exception(e);
    }

  }

}