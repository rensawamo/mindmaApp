import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindmapapp/configs/routes/routes_name.dart';
import 'package:mindmapapp/db/session/session.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/buttons/login_button.dart';

final _firebase = FirebaseAuth.instance;

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, ref, child) {
      return LoginButton(
        title: ref.isLogin ? 'Login' : 'SignUp',
        loading: ref.loginLoading ? true : false,
        onPress: () async {
          Map<String, String> data = {
            'email': ref.email.toString(),
            'password': ref.password.toString(),
          };
          await SessionController().saveUserInPreference(data);

          await SessionController().getUserFromPreference();
          // 既存ユーザはログインさせる
          if (ref.isLogin) {
            await SessionController().saveUserEmail(ref.email.toString());
            await _firebase.signInWithEmailAndPassword(
                email: ref.email.toString(),
                password: ref.password.toString());
            Navigator.pushNamed(context, RoutesName.home);

            //  新しいユーザはアカウントを作成する
          } else {
            await _firebase.createUserWithEmailAndPassword(
                email: ref.email.toString(),
                password: ref.password.toString());
            await SessionController().saveUserEmail(ref.email.toString());
            Navigator.pushNamed(context, RoutesName.home);
          }
        },
      );
    });
  }
}
