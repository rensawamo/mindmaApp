import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindmapapp/configs/design/color.dart';
import 'package:mindmapapp/configs/design/view+extention.dart';
import 'package:mindmapapp/model/user_model/user_model.dart';
import 'package:mindmapapp/view/Home/user/widget/mail.dart';
import 'package:mindmapapp/view/Home/user/widget/mail_widget.dart';
import 'package:mindmapapp/view/Home/user/widget/usercell_widget.dart';
import '../../../DB/local_strage/session/session.dart';
import '../../../DB/local_strage/strage/strage.dart';
import '../../../configs/componets/loading_widget.dart';
import '../../../configs/routes/routes_name.dart';
import '../../../core/widget/delete_dialog_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late LocalStorage sharedPreferenceClass;
  late String user = "";
  late bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    // lacal strqe からの取得の関係で useremailが取得できるか
    // return isLoading
    //     ? const LoadingWidget()
    //     :
    return
      Scaffold(
      body: SingleChildScrollView(
        child: MyApps()
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Center(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         // アプリアイコン情報
        //         children: [
        //           Container(
        //             padding: EdgeInsets.all(10),
        //             width: 100,
        //             decoration: const BoxDecoration(
        //               shape: BoxShape.rectangle,
        //             ),
        //             child: Image.asset('assets/images/dammyicon.png'),
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           SizedBox(
        //             width: context.mediaQueryWidth * .35,
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Life Mind',
        //                   style: TextStyle(
        //                     color: AppColors.blackColor,
        //                     fontSize: 20.0,
        //                     fontWeight: FontWeight.bold
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   height: 5,
        //                 ),
        //                 Text(
        //                   'ver: 0.0.0',
        //                   style: TextStyle(
        //                     color: AppColors.subBlackColor,
        //                     fontSize: 14.0,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 30,
        //     ),
        //     SizedBox(
        //       height:  context.mediaQueryHeight * .7,
        //       width:  context.mediaQueryWidth * .9,
        //       child: Container(
        //         child: Column(
        //           children: [
        //
        //             // GestureDetector(
        //             //   onTap: () async {
        //             //     ShowDeleteDialog(context, "ログアウトしますか？").then((result) async {
        //             //       if (result != null) { //okがおされた場合 launchに飛ばす
        //             //         await FirebaseAuth.instance.signOut();
        //             //         Navigator.pushNamed(context, RoutesName.launch);
        //             //       }
        //             //     });
        //             //   },
        //             //   child: UserCellWidget(icon: Icons.person, title: user,),
        //             // ),
        //             // GestureDetector(
        //             //   onTap: () => print("Log Out tapped."),
        //             //   child: UserCellWidget(icon: Icons.logout, title: 'Log Out'),
        //             // ),
        //             GestureDetector(
        //               onTap: () =>  openMailApp(),
        //               child: UserCellWidget(icon: Icons.settings, title: 'Settings'),
        //             ),
        //             GestureDetector(
        //               onTap: () => print("Notifications tapped."),
        //               child: UserCellWidget(icon: Icons.notifications, title: 'Notifications'),
        //             ),
        //             GestureDetector(
        //               onTap: () => print("FAQs tapped."),
        //               child: UserCellWidget(icon: Icons.chat, title: 'FAQs'),
        //             ),
        //             GestureDetector(
        //               onTap: () => print("Share tapped."),
        //               child: UserCellWidget(icon: Icons.share, title: 'Share'),
        //             ),
        //           ],
        //         )
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }



  void openMailApp() async {
    final title = Uri.encodeComponent('メールの件名');
    final body = Uri.encodeComponent('メール本文');
    const mailAddress = 'molaworker.swift@gmail.com';//メールアドレス

    return launchMail(
      'mailto:$mailAddress?subject=$title&body=$body',
    );
  }

  Future<void> launchMail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final Error error = ArgumentError('Error launching $url');
      throw error;
    }
  }


  // @override
  // local data より userの emailを取得する
  // void initState() {
  //   super.initState();
  //   sharedPreferenceClass = LocalStorage();
  //   Future.microtask(() async {
  //     var userData = await sharedPreferenceClass.readValue('email');
  //     user = userData;
  //     isLoading = false;
  //     setState(() {});
  //   });
  // }
}
