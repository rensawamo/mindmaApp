
import 'package:flutter/material.dart';

import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

class UserCellWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const UserCellWidget({
    required this.icon, required this.title, Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: AppColors.blackColor.withOpacity(.5),
                size: 24,
              ),
              SizedBox(
                    width: context.mediaQueryWidth * .035,
                  ),
              Text(
                title,
                style: AppTexts.title4
              ),
            ],
          ),
        ],
      ),
    );
  }
}