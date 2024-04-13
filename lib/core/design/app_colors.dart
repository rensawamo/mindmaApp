import 'package:flutter/material.dart';

class AppColors {
  static Color whiteColor = Colors.white;
  // font color
  static Color title2Color = const Color.fromARGB(204, 102, 63, 63);

  // ui color
  //Primary color
  static Color primaryColor = const Color(0xff296e48);
  static Color blackColor = Colors.black;
  // サブタイトル用の グレーの文字
  static Color subBlackColor = const Color.fromRGBO(0, 0, 0, 0.3);
  // リストの背景などのグレー
  static Color customGreyColor =
      const Color.fromRGBO(128, 128, 128, 1.0); // 不透明のグレー色
  // app iconの 背景色
  static const Color paleGreen = Color.fromRGBO(227, 235, 227, 1.0);
  // app iconとセットの文字の色
  static Color appFontColor = const Color.fromRGBO(91, 161, 4, 1);

  static Color applistColor = const Color.fromARGB(255, 195, 206, 195);
  
  // ノードのアイコンの色 
  static const Color nodeIconColor = Color.fromARGB(255, 125, 168, 125);


  static Color appbarColor = const Color.fromARGB(255, 157, 194, 157);

  // floating button
  static Color addButtonColor = const Color.fromRGBO(138, 130, 121, 1);

  // マインドマップの 最初のnodeの色 根っこをイメージ
  static Color rootColor = Color.fromARGB(255, 151, 134, 115);

  // マインドマップの子供 nodeの色 葉っぱをイメージ
  static Color leafColor = Color.fromARGB(255, 167, 179, 162);
  
  // マインドマップの 枝の色 木をイメージ
  static Color treeColor = const Color.fromRGBO(119, 94, 83, 1);


  static Color appBottomColor = const Color.fromARGB(255, 202, 201, 149);

  static Color darkGreen = const Color.fromRGBO(21, 105, 84, 1.0);

  static Color lightGreen = const Color.fromARGB(255, 157, 160, 157);

  // 背景色のデフォルトの無効用
  static Color transparent = Colors.transparent;
}
