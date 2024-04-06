import 'package:flutter/material.dart';
import 'package:mindmapapp/configs/design/app_colors.dart';
import 'package:mindmapapp/configs/componets/loading_widget.dart';
import 'package:mindmapapp/configs/design/view+extention.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const LoginButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: context.mediaQueryHeight * .065,
        width: context.mediaQueryWidth * .55,
        decoration: BoxDecoration(
            color: AppColors.darkGreen,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: loading
                ? const LoadingWidget()
                : const Text(
                    'アカウント作成',
                    style: TextStyle(color: AppColors.paleGreen, fontSize: 20),
                  )),
      ),
    );
  }
}
