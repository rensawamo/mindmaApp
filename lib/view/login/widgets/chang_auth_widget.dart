import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/routes/routes_name.dart';


class ChangeAuthWidget extends StatelessWidget {
  const ChangeAuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
        builder: (BuildContext context, LoginViewModel ref, Widget? child) {
      return Column(
        children: <Widget>[
          // ログインか新規登録かを切り替えるボタン
          TextButton(
            onPressed: () {
              ref.setIsLogin();
            },
            child: Text(
              ref.isLogin ? '新しいアカウントを作成しますか？' : 'すでにアカウントをお持ちですか？',
              style: AppTexts.caption,
            ),
          ),

          SizedBox(
            height: context.mediaQueryHeight * .025,
          ),
          // パスワード再設定
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.resetPassword);
            },
            child: Text(
              ref.isLogin ? 'パスワードをお忘れですか？' : '',
              style: AppTexts.caption,
            ),
          ),
        ],
      );
    });
  }
}
