import 'package:flutter/material.dart';
import 'package:mindmapapp/core/widget/delete_dialog_widget.dart';
import 'package:mindmapapp/core/exception/snackbar.dart';

class DeleteNodeButton extends StatelessWidget {
  var deleteNode; // 子 Node を生成する関数

  DeleteNodeButton(this.deleteNode);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ShowDeleteDialog(context, "削除しますか？").then((result) async {
          if (result != null) {
            deleteNode();
          }
        });
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            color: Colors.amber,
          ),
          padding: EdgeInsets.all(5),
          child: Icon(Icons.delete)),
    );
  }
}
