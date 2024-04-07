import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mindmapapp/core/routes/routes_name.dart';
import 'package:mindmapapp/db/session/session.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LaunchViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void checkAuthentication(BuildContext context) async {
    SessionController().getUserFromPreference().then((value) async {
      await _firebaseAuth.currentUser!.reload();
      User? user = _firebaseAuth.currentUser;
      // 一度でもログインしたことがあり、emailの認証が済んでいる場合
      if (SessionController().isLogin! && user != null && user.emailVerified) {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.home, (Route route) => false),
        );
      } else {
        // ログインがまだの場合 ログインに飛ばす
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (Route route) => false),
        );
      }
    }).onError((Object? error, StackTrace stackTrace) {
      //defalutでは loginに飛ばす
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.login, (Route route) => false),
      );
    });
  }
}
