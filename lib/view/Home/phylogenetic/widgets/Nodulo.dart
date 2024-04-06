import 'package:flutter/material.dart';
import 'CommonNode.dart';
import 'NodeOptions.dart';
import 'StartingNode.dart';
import 'package:mindmapapp/core/widget/delete_dialog_widget.dart';
import 'package:mindmapapp/core/exception/snackbar.dart';

class Nodulo extends StatefulWidget {
  final int titleId; // startNodeの id
  final String title; // Node の title
  int? nodeId; // Node の id
  ValueNotifier<int> selectedNode; // 選択されている Node の id
  final Function setSelectedNode; // 選択された Node をセットする関数
  final createSon; // 子 Node を生成する関数
  final createBro; // 兄弟 Node を生成する関数
  final deleteNode; // Node を削除する関数
  final controller; // phylogenetic graph の controller

  Nodulo(
      this.nodeId,
      this.title,
      this.selectedNode,
      this.setSelectedNode,
      this.createSon,
      this.createBro,
      this.controller,
      this.deleteNode,
      this.titleId);

  @override
  State<Nodulo> createState() => _NoduloState(nodeId, title, selectedNode,
      setSelectedNode, createSon, createBro, controller, deleteNode, titleId);
}

class _NoduloState extends State<Nodulo> {
  final int titleId; // startNodeの id
  final String title; // startNode の title
  int? nodeId;
  ValueNotifier<int> selectedNode;
  final Function setSelectedNode;
  final createSon;
  final createBro;
  final deleteNode;
  final controller;

  var isSelected = false;
  bool isFirst = false;
  late FocusNode myFocusNode = new FocusNode();

  void handleFocus(value) {
    if (value == this.nodeId && isSelected == false) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  _NoduloState(
      this.nodeId,
      this.title,
      this.selectedNode,
      this.setSelectedNode,
      this.createSon,
      this.createBro,
      this.controller,
      this.deleteNode,
      this.titleId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 選択されているnodeを更新
        setSelectedNode(nodeId);
      },
      onLongPress: ()  {
        setSelectedNode(nodeId);
      },
      child: ValueListenableBuilder(
        valueListenable: selectedNode,
        builder: (context, value, child) {
          handleFocus(value);
          return Column(children: [
            isFirst
                ? StartingNode(titleId, title, isSelected, selectedNode,
                    setSelectedNode, nodeId, myFocusNode)
                : CommonNode(isSelected, selectedNode, setSelectedNode, nodeId,
                    myFocusNode, titleId, title),
            isSelected
                ? isFirst
                    ? NodeOptions(createSon, createBro,deleteNode, true)
                    : NodeOptions(createSon, createBro,deleteNode, false)
                : Column(),
          ]);
          ;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (this.nodeId == 1) {
      isFirst = true;
    }
    setSelectedNode(nodeId);
    myFocusNode.requestFocus();
    //controller.value = Matrix4.identity();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }
}
