
import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_colors.dart';

void ShowErrorSnackBar(BuildContext context, String message) {
  final SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor:  AppColors.lightGreen, // エラーメッセージ用の背景色\
  );
  // SnackBarを表示
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
