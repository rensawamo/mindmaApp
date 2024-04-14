import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/widget/delete_dialog_widget.dart';
import 'package:mindmapapp/core/routes/routes_name.dart';
import 'package:mindmapapp/view/Home/user/user_page.dart';
import 'package:mindmapapp/core/widget/loading_page.dart';

class DeleteNodeButton extends StatelessWidget {
  final void Function() deleteNode; // 子 Node を生成する関数
  final FocusNode myFocusNode;

  const DeleteNodeButton(this.deleteNode, this.myFocusNode, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ShowDeleteDialog(context, "削除しますか？\nグラフを再構築するため一度リストに戻ります。").then((bool? result) async {
          if (result != null) {
            myFocusNode.unfocus();
            deleteNode();
            Navigator.of(context).pop();
          }
        });
      },
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            color: AppColors.nodeIconColor,
          ),
          padding: const EdgeInsets.all(5),
          child: const Icon(Icons.delete, color: Colors.white)),
    );
  }
}
