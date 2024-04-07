
import 'package:flutter/material.dart';

void ShowErrorSnackBar(BuildContext context, String message) {
  final SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: const Color.fromARGB(255, 177, 244, 54), // エラーメッセージ用の背景色\
  );
  // SnackBarを表示
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
