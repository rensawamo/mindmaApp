import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindmapapp/core/routes/routes_name.dart';
import 'package:mindmapapp/db/session/session.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/buttons/login_button.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/exception/firebase_auth_error.dart';
import 'package:mindmapapp/core/enum/firebase_auth_error.dart';
import 'package:mindmapapp/core/utils/firebase_auth_error.dart';
import 'package:firebase_core/firebase_core.dart';

final _firebase = FirebaseAuth.instance;

class LoginButtonWidget extends StatefulWidget {
  const LoginButtonWidget({
    Key? key,
  }) : super(key: key);
  @override
  _LoginButtonWidget createState() => _LoginButtonWidget();
}

class _LoginButtonWidget extends State<LoginButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, ref, child) {
      return Column(
        children: <Widget>[
          Text(ref.errorMessage ?? ""),
          SizedBox(
            // firebase のエラー用の
            height: context.mediaQueryHeight * .002,
          ),
          LoginButton(
            title: ref.isLogin ? 'Login' : 'SignUp',
            loading: ref.loginLoading ? true : false,
            onPress: () async {
              Map<String, String> data = {
                'email': ref.email.toString(),
                'password': ref.password.toString(),
              };
              ref.setLoginLoading(true);

              // 既存ユーザはログインさせる
              if (ref.isLogin) {
                try {
                  // ログインが成功したとき
                  await _firebase.signInWithEmailAndPassword(
                      email: ref.email.toString(),
                      password: ref.password.toString());
                  await SessionController().saveUserEmail(ref.email.toString());
                  await SessionController().saveUserInPreference(data);
                  Navigator.pushNamed(context, RoutesName.home);
                  ref.errorMessage = null;
                } on FirebaseAuthException catch (e) {
                  ref.errorMessage = e.toString();
                }
                //  新しいユーザはアカウントを作成する
              } else {
                try {
                  await _firebase.createUserWithEmailAndPassword(
                      email: ref.email.toString(),
                      password: ref.password.toString());
                  await SessionController().saveUserEmail(ref.email.toString());
                  await SessionController().saveUserInPreference(data);
                  ref.errorMessage = null;

                  Navigator.pushNamed(context, RoutesName.home);
                } on FirebaseAuthException catch (e) {
                  ref.errorMessage = e.toString();
                }
              }
              ref.setLoginLoading(false);
            },
          )
        ],
      );
    });
  }
}
