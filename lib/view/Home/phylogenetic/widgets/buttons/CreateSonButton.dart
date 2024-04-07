import 'package:flutter/material.dart';

class CreateSonButton extends StatelessWidget {
  final void Function() createSon;

  const CreateSonButton(this.createSon, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: createSon,
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            color: Colors.amber,
          ),
          padding: const EdgeInsets.all(5),
          child: const Icon(Icons.add)),
    );
  }
}
