import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/componets/loading_widget.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

class CertificationButtonWidget extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const CertificationButtonWidget({
    required this.title, required this.onPress, Key? key,
    this.loading = false,
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
                    '認証',
                    style: TextStyle(color: AppColors.paleGreen, fontSize: 20),
                  )),
      ),
    );
  }
}
