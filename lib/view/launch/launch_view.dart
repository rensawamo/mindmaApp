import 'package:flutter/material.dart';

import '../../view_model/launch/launch_view_model.dart';



class LaunchView extends StatefulWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  State<LaunchView> createState() => _SplashViewState();
}

class _SplashViewState extends State<LaunchView> {

  LaunchViewModel splashServices = LaunchViewModel();

  @override
  void initState() {
    super.initState();

    splashServices.checkAuthentication(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text('Splash screen', style: Theme.of(context).textTheme.headlineMedium,),
      ),
    );
  }
}

