
import 'package:flutter/material.dart';

import '../../../../configs/design/color.dart';

class UserCellWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const UserCellWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.blackColor.withOpacity(.5),
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}