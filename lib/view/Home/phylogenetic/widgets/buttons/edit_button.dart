import 'package:flutter/material.dart';
import 'package:mindmapapp/core/componets/popover.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/edit_list.dart';
import 'package:popover/popover.dart';

class EditButton extends StatelessWidget {
  final void Function() edit;
  final bool isFirst;

  const EditButton(this.edit, this.isFirst, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
          showPopover(
            context: context,
            bodyBuilder: (context) => const MyDropdownScreen(),
            onPop: () => print('Popover was popped!'),
            direction: PopoverDirection.bottom,
            width: 200,
            height: 400,
            arrowHeight: 15,
            arrowWidth: 30,
          );
        },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          color: isFirst ? AppColors.rootColor : AppColors.nodeIconColor,
        ),
        padding: const EdgeInsets.all(5),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
