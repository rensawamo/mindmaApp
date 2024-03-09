import 'package:flutter/material.dart';
import 'package:mindmapapp/configs/routes/routes_name.dart';

import '../../view/Home/Home_view.dart';
import '../../view/Home/phylogenetic/Phylogenetic_view.dart';
import '../../view/launch/launch_view.dart';
import '../../view/login/login_view.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => Home());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());

      //    launch screen
      case RoutesName.launch:
        return MaterialPageRoute(builder: (BuildContext context) => const LaunchView());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined.'),
            ),
          );
        });
    }
  }
}