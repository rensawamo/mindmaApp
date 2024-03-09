import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../configs/utils.dart';
import '../../../view_model/login/login_view_model.dart';

class ChangeAuthWidget extends StatelessWidget {

  const ChangeAuthWidget(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, provider, child) {
      return TextButton(
        onPressed: () {
          provider.setIsLogin();
        },
        child: Text(provider.isLogin
            ? '新しいアカウントを作成しますか？'
            : 'すでにアカウントをお持ちですか？'),
      );
    });
  }
}
