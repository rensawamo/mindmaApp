import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindmapapp/core/routes/routes_name.dart';
import 'package:mindmapapp/db/session/session.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/buttons/login_button.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/exception/firebase_auth_exception.dart';
import 'package:mindmapapp/core/utils/firebase_auth_error.dart';
import 'package:mindmapapp/core/design/app_texts.dart';

final FirebaseAuth _firebase = FirebaseAuth.instance;

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
    return Consumer<LoginViewModel>(
        builder: (BuildContext context, LoginViewModel ref, Widget? child) {
      return Column(
        children: <Widget>[
          // エラーメッセージ
          Text(ref.errorMessage ?? "", style: AppTexts.error),
          
          SizedBox(
            height: context.mediaQueryHeight * .003,
          ),
          LoginButton(
            title: ref.isLogin ? 'Login' : 'SignUp',
            loading: ref.loginLoading ? true : false,
            onPress: () async {
              if (ref.email.isEmpty || ref.password.isEmpty) {
                ref.errorMessage = "正しく入力してください。";
                ref.setLoginLoading(false);
                return;
              }
              // session用のデータ
              Map<String, String> data = <String, String>{
                'email': ref.email.toString(),
                'password': ref.password.toString(),
              };
              ref.setLoginLoading(true); // ローディングを表示
              print(ref.checkEmailVerified());
              bool isMailCheck = await ref.checkEmailVerified();
              // 既存ユーザはログインさせる
              if (ref.isLogin) {
                try {
                  // ログインが成功したとき
                  await _firebase.signInWithEmailAndPassword(
                      email: ref.email.toString(),
                      password: ref.password.toString());
                  if (isMailCheck == false) {
                    // emailの確認がまだ完了していない時
                    Navigator.pushNamed(context, RoutesName.emailAuth);
                  } else {
                    // emailの確認が完了している時
                    Navigator.pushNamed(context, RoutesName.home);
                  }
                  ref.setLoginLoading(false);
                  ref.errorMessage = null;
                } on FirebaseAuthException catch (e) {
                  ref.errorMessage = exceptionMessage(handleException(e));
                }
                //  新しいユーザはアカウントを作成する
              } else {
                try {
                  // 一時的に userを作成して emailの確認に進む
                  final UserCredential userCredential =
                      await _firebase.createUserWithEmailAndPassword(
                          email: ref.email.toString(),
                          password: ref.password.toString());
                  // ユーザーがnullでないことを確認
                  if (userCredential.user != null) {
                    // 確認メールを送信
                    await userCredential.user!.sendEmailVerification();
                  } else {
                    // ユーザー作成に失敗
                    ref.errorMessage = "ユーザーの作成に失敗しました。";
                    ref.setLoginLoading(false);
                    return;
                  }
                  // emailの確認を行う
                  Navigator.pushNamed(context, RoutesName.emailAuth);
                  ref.setLoginLoading(false);
                  ref.errorMessage = null;
                } on FirebaseAuthException catch (e) {
                  // Firebaseのエラーをハンドリング
                  print(e.code);
                  ref.errorMessage =
                      exceptionMessage(handleException(e)); // エラーメッセージを適切に設定
                }
              }
              ref.setLoginLoading(false);

              // sessionを更新
              await SessionController().saveUserEmail(ref.email.toString());
              await SessionController().saveUserInPreference(data);
            },
          ),
        ],
      );
    });
  }
}
