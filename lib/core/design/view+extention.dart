import 'package:flutter/material.dart';

// 画面のサイズを取得するショートカット
extension MediaQueryValues on BuildContext {
  double get mediaQueryHeight => MediaQuery.sizeOf(this).height;
  double get mediaQueryWidth => MediaQuery.sizeOf(this).width ;
}

//  spacerのショートカット
extension EmptySpace on num {
  SizedBox get height => SizedBox(height:toDouble());
  SizedBox get width => SizedBox(width:toDouble());
}