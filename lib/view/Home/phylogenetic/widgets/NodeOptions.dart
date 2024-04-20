import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

import 'buttons/CreateBroButton.dart';
import 'buttons/CreateSonButton.dart';
import 'buttons/delete_node_button.dart';

class NodeOptions extends StatelessWidget {
  final void Function() createSon; // 子 Node を生成する関数
  final void Function() createBro; // 兄弟 Node を生成する関数
  final Future<bool> Function() deleteNode; // Node を削除する関数
  final FocusNode myFocusNode;

  final bool isFirst; // 一番最初の Node かどうか

  const NodeOptions(this.createSon, this.createBro, this.deleteNode,
      this.myFocusNode, this.isFirst,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isFirst
            // 最初のnodeの場合は兄弟nodeを生成するボタンは表示しない
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[CreateSonButton(createSon, isFirst)],
              )
            // その他 共通のNode
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                // 子Nodeを生成するボタン、兄弟Nodeを生成するボタン、Nodeを削除するボタン
                children: <Widget>[
                  CreateSonButton(createSon, isFirst),
                  SizedBox(
                    width: context.mediaQueryWidth * .05,
                  ),
                  CreateBroButton(createBro),
                  SizedBox(
                    width: context.mediaQueryWidth * .05,
                  ),
                  DeleteNodeButton(deleteNode)
                ],
              ));
  }
}
