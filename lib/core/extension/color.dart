import 'package:flutter/material.dart';

// Colorクラスに対するカスタム拡張
extension ColorExtension on Color {
  static Color getColorFromChoice(String color) {
    switch (color) {
      case "黒":
        return Colors.black;
      case "赤":
        return Colors.red;
      case "青":
        return Colors.blue;
      case "黄色":
        return Colors.yellow;
      case "オレンジ":
        return Colors.orange;
      case "緑":
        return Colors.green;
      default:
        return Colors.grey; // default color
    }
  }
}
