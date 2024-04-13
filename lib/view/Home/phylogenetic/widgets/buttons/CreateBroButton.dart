import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mindmapapp/core/design/app_colors.dart';

class CreateBroButton extends StatelessWidget {
  final void Function() createBro;

  const CreateBroButton(this.createBro, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: createBro,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          color: AppColors.nodeIconColor,
        ),
        child: Transform.rotate(
          angle: pi / 2,
          child: const Icon(Icons.alt_route_rounded,color: Colors.white),
        ),
      ),
    );
  }
}
