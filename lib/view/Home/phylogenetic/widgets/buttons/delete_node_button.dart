import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapapp/core/componets/snackbar.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/widget/delete_dialog_widget.dart';

class DeleteNodeButton extends StatefulWidget {
  final Future<bool> Function() deleteNode; // 子 Node を削除する関数

  const DeleteNodeButton(this.deleteNode, {super.key});

  @override
  _DeleteNodeButtonState createState() => _DeleteNodeButtonState();
}

class _DeleteNodeButtonState extends State<DeleteNodeButton> {
  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () async {
      bool? result = await ShowDeleteDialog(context, "削除しますか？");
      if (result == true) {
        try {
          await widget.deleteNode();
          if (mounted) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          if (mounted) {
            ShowErrorSnackBar(context, 'エラーが発生しました: $e');
          }
        }
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.red, // 仮の色指定
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: Icon(Icons.delete, color: Colors.white),
    ),
  );
}
}
