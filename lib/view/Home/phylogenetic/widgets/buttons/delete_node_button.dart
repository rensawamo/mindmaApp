import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/widget/delete_dialog_widget.dart';

class DeleteNodeButton extends StatefulWidget {
  final Future<void> Function() deleteNode; // 子 Node を削除する関数

  const DeleteNodeButton(this.deleteNode, {super.key});

  @override
  _DeleteNodeButtonState createState() => _DeleteNodeButtonState();
}

class _DeleteNodeButtonState extends State<DeleteNodeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // キーボードが出たままでnavigationするとエラーが出るため、キーボードを閉じる
        FocusManager.instance.primaryFocus?.unfocus();
        bool? result =
            await ShowDeleteDialog(context, "削除しますか？ \nグラフ再描写のため一度元の画面に戻ります。");
        if (result == true) {
          try {
            await widget.deleteNode();
            if (mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            print(e); // ローディングでliteへbackして再描写を促す isloadingより
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          color: AppColors.nodeIconColor,
        ),
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
