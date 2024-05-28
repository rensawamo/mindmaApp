
import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/view/Home/user/widget/usercell_widget.dart';
import 'package:mindmapapp/db/strage/local_storage.dart';
import 'package:mindmapapp/core/componets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserPage> {
  late LocalStorage sharedPreferenceClass;
  late String user = "";
  late bool isLoading = true;

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // lacal strqe からの取得の関係で useremailが取得している間はローディングを表示 ver0.0.0はなし
    // isLoading
    //     ? const LoadingWidget()
    //     :
    return  Container(
            color: AppColors.paleGreen,
            child: Scaffold(
              backgroundColor: AppColors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // アプリアイコン情報
                        children: <Widget>[
                          SizedBox(
                            height: context.mediaQueryHeight * .015,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: context.mediaQueryHeight * .15,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            child: Image.asset('assets/images/Group.png'),
                          ),
                          SizedBox(
                            width: context.mediaQueryWidth * .35,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Life Mind',
                                  style: AppTexts.title3,
                                ),
                                Text(
                                  'ver: 0.0.3',
                                  style: AppTexts.caption2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.mediaQueryHeight * .035,
                    ),
                    SizedBox(
                      height: context.mediaQueryHeight * .7,
                      width: context.mediaQueryWidth * .9,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              // ユーザのメールアドレス
                              // GestureDetector(
                              //   child: UserCellWidget(
                              //     icon: Icons.person,
                              //     title: user,
                              //   ),
                              // ),
                              // const Divider(),
                              // GestureDetector(
                              //   onTap: () async {
                              //     ShowDeleteDialog(context, "ログアウトしますか？")
                              //         .then((bool? result) async {
                              //       if (result != null) {
                              //         // firebase のログアウト
                              //         await FirebaseAuth.instance.signOut();
                              //         // session を破壊
                              //         await SessionController().sessionClear();
                              //         // login 画面に戻す stackの削除
                              //         Navigator.pushAndRemoveUntil(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (BuildContext context) =>
                              //                   const LoginPage()),
                              //           (Route<dynamic> route) => false,
                              //         );
                              //       }
                              //     });
                              //   },
                              //   child: const UserCellWidget(
                              //       icon: Icons.logout, title: 'Log Out'),
                              // ),
                              const Divider(),
                              GestureDetector(
                                onTap: () => launchURL(
                                    'https://wonderful-flower-033138b00.5.azurestaticapps.net/'),
                                child: const UserCellWidget(
                                    icon: Icons.web, title: 'website'),
                              ),
                              const Divider(),
                              // GestureDetector(
                              //   onTap: () => print("FAQs tapped."),
                              //   child: const UserCellWidget(
                              //       icon: Icons.chat, title: 'FAQs'),
                              // ),
                              // const Divider(),
                              GestureDetector(
                                onTap: () => launchURL(
                                    'https://wonderful-flower-033138b00.5.azurestaticapps.net/privacypolicy'),
                                child: const UserCellWidget(
                                    icon: Icons.question_answer_rounded,
                                    title: 'プライバシーポリシー'),
                              ),
                              const Divider(),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ));
  }

  // void openMailApp() async {
  //   final title = Uri.encodeComponent('メールの件名');
  //   final body = Uri.encodeComponent('メール本文');
  //   const mailAddress = 'molaworker.swift@gmail.com';//メールアドレス
  //
  //   return launchMail(
  //     'mailto:$mailAddress?subject=$title&body=$body',
  //   );
  // }
  //
  // Future<void> launchMail(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     final Error error = ArgumentError('Error launching $url');
  //     throw error;
  //   }
  // }

  @override
  // local data より userの emailを取得する
  void initState() {
    super.initState();
    // sharedPreferenceClass = LocalStorage();
    // Future.microtask(() async {
    //   var userData = await sharedPreferenceClass.readValue('email');
    //   user = userData;
    //   isLoading = false;
    //   setState(() {});
    // });
  }
}
