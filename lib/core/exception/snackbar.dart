
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void ShowErrorSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.red, // エラーメッセージ用の背景色を赤に設定
  );
  // SnackBarを表示
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
