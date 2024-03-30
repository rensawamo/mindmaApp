import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindmapapp/configs/design/view+extention.dart';
import 'package:mindmapapp/view/Home/Home_view.dart';
import 'package:mindmapapp/view/login/widgets/chang_auth_widget.dart';
import 'package:mindmapapp/view/login/widgets/email_widget.dart';
import 'package:mindmapapp/view/login/widgets/login_button_widget.dart';
import 'package:mindmapapp/view/login/widgets/password_widget.dart';

import '../../configs/routes/routes_name.dart';
import '../../view_model/login/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputEmailWidget(
                  focusNode: emailFocusNode,
                  passwordFocusNode: passwordFocusNode),
              InputPasswordWidget(focusNode: passwordFocusNode),
              SizedBox(
                height: context.mediaQueryHeight * .085,
              ),
              const LoginButtonWidget(),
              SizedBox(
                height: context.mediaQueryHeight * .02,
              ),
              const ChangeAuthWidget(),
              SizedBox(
                height: context.mediaQueryHeight * .02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
