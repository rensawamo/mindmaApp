import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_colors.dart';

class CreateSonButton extends StatelessWidget {
  final void Function() createSon;
  final bool isFirst;

  const CreateSonButton(this.createSon, this.isFirst, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: createSon,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          color: isFirst ? AppColors.rootColor : AppColors.nodeIconColor,
        ),
        padding: const EdgeInsets.all(5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
