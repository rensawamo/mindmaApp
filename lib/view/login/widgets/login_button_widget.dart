import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DB/local_strage/session/session.dart';
import '../../../configs/routes/routes_name.dart';
import '../../../configs/utils.dart';
import '../../../configs/validator.dart';
import '../../../view_model/login/login_view_model.dart';
import '../../Home/phylogenetic/widgets/login_button.dart';

final _firebase = FirebaseAuth.instance;
class LoginButtonWidget extends StatelessWidget {
  const   LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, provider, child) {
      return RoundButton(
        title: provider.isLogin ? 'Login' : 'SignUp',
        loading: provider.loginLoading ? true : false,
        onPress: () async {
          Map data = {
            'email' : provider.email.toString(),
            'password' : provider.password.toString(),
          };
          await SessionController()
              .saveUserInPreference(data);

          await SessionController().getUserFromPreference();
          // 既存ユーザはログインさせる
          if (provider.isLogin) {
            await SessionController().saveUserEmail(provider.email.toString());
            await _firebase.signInWithEmailAndPassword(
                email: provider.email.toString(), password: provider.password.toString());
            Navigator.pushNamed(context, RoutesName.home);

            //  新しいユーザはアカウントを作成する
          } else {
            await _firebase.createUserWithEmailAndPassword(
                email: provider.email.toString(),
                password: provider.password.toString());
            await SessionController().saveUserEmail(provider.email.toString());
            Navigator.pushNamed(context, RoutesName.home);
          }
        },
      );
    });
  }
}
