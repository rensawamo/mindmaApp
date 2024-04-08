import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String _message = '';

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      setState(() {
        _message = 'パスワードリセットメールを送信しました。メールを確認してください。';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        print(e.code); // 分岐
        _message = 'メールアドレスを正しく入力してください。';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.paleGreen,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          title: const Text('パスワードリセット'),
          backgroundColor: AppColors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'パスワードリセットのためのメールアドレスを入力してください。',
                style: AppTexts.body,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'メールアドレス'),
              ),
              SizedBox(
                height: context.mediaQueryHeight * .04,
              ),
              GestureDetector(
                onTap: _resetPassword,
                child: Container(
                  height: context.mediaQueryHeight * .065,
                  width: context.mediaQueryWidth * .55,
                  decoration: BoxDecoration(
                      color: AppColors.darkGreen,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    'リセットメールを送信',
                    style: TextStyle(color: AppColors.paleGreen, fontSize: 16),
                  )),
                ),
              ),
              SizedBox(
                height: context.mediaQueryHeight * .04,
              ),
              Text(_message, style: AppTexts.error),
            ],
          ),
        ),
      ),
    );
  }
}
