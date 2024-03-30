import 'package:flutter/material.dart';
import 'package:mindmapapp/configs/design/color.dart';
import 'package:mindmapapp/view/Home/user/widget/usercell_widget.dart';


class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // SingleChildScrollViewはウィジェットの大きさが端末の領域以上になる場合に、スクロールできるようにするウィジェット
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Image.asset('assets/images/dammyicon.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width * .35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Life Mind',
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'ver: 0.0.0',
                              style: TextStyle(
                                color: AppColors.subBlackColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: size.height * .7,
                  width: size.width,

                  child:  Container(
                      child: const Column(
                          children: [
                            UserCellWidget(
                              icon: Icons.person,
                              title: 'My Profile',
                            ),
                            UserCellWidget(
                              icon: Icons.settings,
                              title: 'Settings',
                            ),
                            UserCellWidget(
                              icon: Icons.notifications,
                              title: 'Notifications',
                            ),
                            UserCellWidget(
                              icon: Icons.chat,
                              title: 'FAQs',
                            ),
                            UserCellWidget(
                              icon: Icons.share,
                              title: 'Share',
                            ),
                            UserCellWidget(
                              icon: Icons.logout,
                              title: 'Log Out',
                            ),
                          ],
                      ),
                    ),


                  ),

              ],
            ),
          ),
        ));
  }
}

