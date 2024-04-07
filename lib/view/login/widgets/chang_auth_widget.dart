import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
class ChangeAuthWidget extends StatelessWidget {

  const ChangeAuthWidget(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (BuildContext context, LoginViewModel ref, Widget? child) {
      return TextButton(
        onPressed: () {
          ref.setIsLogin();
        },
        child:
        Text(ref.isLogin
            ? '新しいアカウントを作成しますか？'
            : 'すでにアカウントをお持ちですか？',
            style: AppTexts.caption,),
      )
      ;
    });
  }
}
