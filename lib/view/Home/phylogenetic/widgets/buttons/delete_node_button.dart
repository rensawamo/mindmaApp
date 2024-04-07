import 'package:flutter/material.dart';
import 'package:mindmapapp/core/widget/delete_dialog_widget.dart';


class DeleteNodeButton extends StatelessWidget {
  final void Function() deleteNode; // 子 Node を生成する関数

  const DeleteNodeButton(this.deleteNode, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ShowDeleteDialog(context, "削除しますか？").then((bool? result) async {
          if (result != null) {
            deleteNode();
          }
        });
      },
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            color: Colors.amber,
          ),
          padding: const EdgeInsets.all(5),
          child: const Icon(Icons.delete)),
    );
  }
}
