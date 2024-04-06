import 'package:flutter/material.dart';
import 'package:mindmapapp/view_model/launch/launch_view_model.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/app_texts.dart';

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
      body: Container(
        color: AppColors.paleGreen,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Image.asset('assets/images/launch.png'),
            ),
            Text(
              'Life Mind',
              style: AppTexts.launch,
            ),
          ],
        ),
      ),
    );
  }
}
