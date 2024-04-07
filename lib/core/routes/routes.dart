import 'package:flutter/material.dart';
import 'package:mindmapapp/core/routes/routes_name.dart';

import 'package:mindmapapp/view/Home/home_page.dart';
import 'package:mindmapapp/view/launch/launch_page.dart';
import 'package:mindmapapp/view/login/login_page.dart';
import 'package:mindmapapp/view/login/email_verification_page.dart';



class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // phylogenetic と setting
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeView());

      case RoutesName.login:
        // ver  0.0.0では local strageのみとする
        // ver upで firestoreと 認証を合わしていく
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
      // return MaterialPageRoute(builder: (BuildContext context) => HomeView());

      //    launch screen
      case RoutesName.launch:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LaunchView());

      //  email auth screen
      case RoutesName.emailAuth:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EmailVerificationPage());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('エラー画面'),
            ),
          );
        });
    }
  }
}
