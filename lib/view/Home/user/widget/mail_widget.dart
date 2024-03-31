// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
//
// class MailPackage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _MailPackage();
// }
//
// class _MailPackage extends State<MailPackage> {
//   TextEditingController emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('メールパッケージ'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               decoration: InputDecoration(hintText: 'メールアドレスを入力してください'),
//             ),
//             ElevatedButton(
//               child: Text('url_launcherで送る'),
//               onPressed: () {
//                 urlLauncherMail();
//               },
//             ),
//             ElevatedButton(
//               child: Text('flutter_email_senderで送る'),
//               onPressed: () {
//                 flutterEmailSenderMail();
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
// //url_launcherを使ってメールを送信
//   urlLauncherMail() {
//     final Uri _emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: '${emailController.text}',
//       queryParameters: {
//         'subject': 'url_launcherを使ってメールを送ります！',
//         'body': '${Template().text}'
//       },
//     );
//
//     return launch(
//       _emailLaunchUri.toString(),
//     );
//   }
//
// //flutter_email_senderを使ってメールを送信
//   flutterEmailSenderMail() async {
//     final Email email = Email(
//       body: '${Template().text}',
//       subject: 'flutter_email_senderを使ってメールを送っています！',
//       recipients: ['${emailController.text}'],
//       attachmentPaths: ['images/sample1.png'],
//     );
//
//     await FlutterEmailSender.send(email);
//   }
// }
//
// //本文のテンプレート的な
// class Template {
//   String text =
//       'お疲れ様です。テスト通知です。\n\nメールは届いているでしょうか？\n\n届いておりましたら、お返事お待ちしております。\nこちらのURLもみてくださいね\n\nhttps://qiita.com/ryota47/items/fb8e32f1a409026ba065';
// }
