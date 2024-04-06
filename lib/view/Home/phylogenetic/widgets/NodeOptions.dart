import 'package:flutter/material.dart';

import 'buttons/CreateBroButton.dart';
import 'buttons/CreateSonButton.dart';
import 'buttons/delete_node_button.dart';

class NodeOptions extends StatelessWidget {
  final void Function() createSon; // 子 Node を生成する関数
  final void Function() createBro; // 兄弟 Node を生成する関数
  final void Function() deleteNode; // Node を削除する関数
  final bool isFirst; // 一番最初の Node かどうか

  NodeOptions(this.createSon, this.createBro, this.deleteNode, this.isFirst);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isFirst
            // 最初のnodeの場合は兄弟nodeを生成するボタンは表示しない
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CreateSonButton(createSon)],
              )
            // その他 共通のNode
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                // 子Nodeを生成するボタン、兄弟Nodeを生成するボタン、Nodeを削除するボタン
                children: [
                  CreateSonButton(createSon),
                  SizedBox(width: 12),
                  CreateBroButton(createBro),
                  SizedBox(width: 12),
                  DeleteNodeButton(deleteNode)
                ],
              ));
  }
}
