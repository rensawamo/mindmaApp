import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindmapapp/core/routes/routes_name.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isChecking = false;
  String message = '登録したメールアドレスに確認メールを送信しました。\nメール内のリンクをクリックしてください。';

  @override
  void initState() {
    super.initState();
    checkEmailVerified();
  }

  Future<void> checkEmailVerified() async {
    setState(() => isChecking = true);

    // ユーザーが最新の情報に更新されていることを確認
    await _firebaseAuth.currentUser!.reload();
    User? user = _firebaseAuth.currentUser;

    if (user != null && user.emailVerified) {
      // メールが確認されていれば、ホーム画面に移動
      Navigator.pushNamed(context, RoutesName.home);
    } else {
      setState(() {
        isChecking = false;
        message = 'メールアドレスがまだ確認されていません。\n確認メールのリンクをクリックしてください。';
      });
    }
  }

  // メールを再送信
  Future<void> resendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      setState(() {
        message = '確認メールを再送しました。メールをチェックして、リンクをクリックしてください。';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("メールアドレスの確認"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.paleGreen, // Scaffoldの背景色を設定
      body: Center(
        child: isChecking
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: context.mediaQueryHeight * .04,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTexts.body,
                  ),
                  SizedBox(
                    height: context.mediaQueryHeight * .035,
                  ),
                  GestureDetector(
                    onTap: checkEmailVerified,
                    child: Container(
                      height: context.mediaQueryHeight * .065,
                      width: context.mediaQueryWidth * .55,
                      decoration: BoxDecoration(
                          color: AppColors.darkGreen,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        '確認済み',
                        style:
                            TextStyle(color: AppColors.paleGreen, fontSize: 16),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: context.mediaQueryHeight * .035,
                  ),
                  GestureDetector(
                    onTap: resendEmailVerification,
                    child: Container(
                      height: context.mediaQueryHeight * .065,
                      width: context.mediaQueryWidth * .55,
                      decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'メールを再送する',
                        style:
                            TextStyle(color: AppColors.paleGreen, fontSize: 16),
                      )),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
