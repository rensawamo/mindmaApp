import 'package:flutter/material.dart';
import 'package:mindmapapp/configs/design/view+extention.dart';
import 'package:mindmapapp/view/login/widgets/email_widget.dart';
import 'package:mindmapapp/view/login/widgets/login_button_widget.dart';
import 'package:mindmapapp/view/login/widgets/password_widget.dart';

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
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputEmailWidget(focusNode: emailFocusNode, passwordFocusNode: passwordFocusNode),
              InputPasswordWidget(focusNode: passwordFocusNode),
              SizedBox(height: context.mediaQueryHeight * .085,),
              const LoginButtonWidget(),
              SizedBox(height: context.mediaQueryHeight * .02,),
            ],
          ),
        ),
      ),
    );
  }
}

