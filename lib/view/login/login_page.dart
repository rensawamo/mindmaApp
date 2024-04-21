// import 'package:flutter/material.dart';
// import 'package:mindmapapp/core/design/view+extention.dart';
// import 'package:mindmapapp/view/login/widgets/chang_auth_widget.dart';
// import 'package:mindmapapp/view/login/widgets/email_widget.dart';
// import 'package:mindmapapp/view/login/widgets/login_button_widget.dart';
// import 'package:mindmapapp/view/login/widgets/password_widget.dart';
// import 'package:mindmapapp/core/design/app_colors.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode passwordFocusNode = FocusNode();

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailFocusNode.dispose();
//     passwordFocusNode.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       color: AppColors.paleGreen,
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               InputEmailWidget(
//                   focusNode: emailFocusNode,
//                   passwordFocusNode: passwordFocusNode),
//               PasswordWidget(focusNode: passwordFocusNode),
//               SizedBox(
//                 height: context.mediaQueryHeight * .045,
//               ),
//               const LoginButtonWidget(),
//               SizedBox(
//                 height: context.mediaQueryHeight * .03,
//               ),
//               const ChangeAuthWidget(),
//               SizedBox(
//                 height: context.mediaQueryHeight * .02,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
