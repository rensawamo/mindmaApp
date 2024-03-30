import 'dart:async';
import 'package:flutter/material.dart';
import '../../../configs/routes/routes_name.dart';
import '../../DB/local_strage/session/session.dart';


class LaunchViewModel {
  void checkAuthentication(BuildContext context) async {
    SessionController().getUserFromPreference().then((value)async{
      // 一度でもログインしたことがある場合
      if(SessionController().isLogin!){
        Timer(const Duration(seconds: 2),
              () =>
              Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false),
        );
      }else {
        // ログインがまだの場合 登録かログインに飛ばす
        Timer(const Duration(seconds: 2),
              () =>
              Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
        );
      }
    }).onError((error, stackTrace){
      Timer(const Duration(seconds: 2),
            () =>
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
      );
    });
  }
}