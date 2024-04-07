// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mindmapapp/view_model/login/email_verfication_view_model.dart';
// import 'package:mindmapapp/core/routes/routes_name.dart';
// import 'package:mindmapapp/core/componets/loading_widget.dart';

// class EmailVerificationPage extends ConsumerStatefulWidget {
//   const EmailVerificationPage({super.key});

//   @override
//   ConsumerState<EmailVerificationPage> createState() =>
//       _EmailVerificationScreenState();
// }

// class _EmailVerificationScreenState
//     extends ConsumerState<EmailVerificationPage> {
//   final ChangeNotifierProvider<EmailVericationViewModel> viewModel =
//       ChangeNotifierProvider((ChangeNotifierProviderRef<Object?> ref) =>
//           EmailVericationViewModel());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("メールアドレスの確認"),
//       ),
//       body: Center(
//         child: ref.watch(viewModel).isChecking
//             ? const LoadingWidget()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     ref.watch(viewModel).message ?? "",
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     // メールの認証が完了している場合にホーム画面に遷移
//                     onPressed: () async {
//                       bool isMailCheck =
//                           await ref.watch(viewModel).checkEmailVerified();
//                       if (isMailCheck) {
//                         Navigator.pushNamed(context, RoutesName.home);
//                       }
//                     },
//                     child: const Text('確認済み'),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await ref.watch(viewModel).resendEmailVerification();
//                     },
//                     child: const Text('メールを再送する'),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindmapapp/core/routes/routes_name.dart';


class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationPage> {
  final _firebaseAuth = FirebaseAuth.instance;
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
    var user = _firebaseAuth.currentUser;

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

  Future<void> resendEmailVerification() async {
    var user = _firebaseAuth.currentUser;
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
        title: Text("メールアドレスの確認"),
      ),
      body: Center(
        child: isChecking
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await checkEmailVerified();
                    },
                    child: Text('確認済み'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await resendEmailVerification();
                    },
                    child: Text('メールを再送する'),
                  ),
                ],
              ),
      ),
    );
  }
}
