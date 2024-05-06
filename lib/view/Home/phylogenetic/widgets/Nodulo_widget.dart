import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'common_node_widget.dart';
import 'node_options_widget.dart';
import 'starting_node_widget.dart';

class NoduloWidget extends StatefulWidget {
  final int titleId; // startNodeの id
  final String title; // Node の title
  final bool isBold;
  final bool isItalic;
  final bool isStripe;
  final String color;
  final int? nodeId; // Node の id
  final ValueNotifier<int> selectedNode; // 選択されている Node の id
  final Function setSelectedNode; // 選択された Node をセットする関数
  final void Function() createSon; // 子 Node を生成する関数
  final void Function() createBro; // 兄弟 Node を生成する関数
  final Future<void> Function() deleteNode; // Node を削除する関数
  final controller; // transform controller
  final Uint8List? image;

  const NoduloWidget(
      this.nodeId,
      this.title,
      this.isBold,
      this.isItalic,
      this.isStripe,
      this.color,
      this.selectedNode,
      this.setSelectedNode,
      this.createSon,
      this.createBro,
      this.controller,
      this.deleteNode,
      this.titleId,
      this.image,
      {super.key});

  @override
  State<NoduloWidget> createState() => _NoduloState(
      nodeId,
      title,
      isBold,
      isItalic,
      isStripe,
      color,
      selectedNode,
      setSelectedNode,
      createSon,
      createBro,
      controller,
      deleteNode,
      titleId,
      image);
}

class _NoduloState extends State<NoduloWidget> {
  final int titleId; // startNodeの id
  final String title; // startNode の title
  final bool isBold;
  final bool isItalic;
  final bool isStripe;
  final String color;
  int? nodeId;
  ValueNotifier<int> selectedNode;
  Function setSelectedNode;
  void Function() createSon;
  void Function() createBro;
  Future<void> Function() deleteNode;
  final controller;

  bool isSelected = false;
  bool isFirst = false;
  late FocusNode myFocusNode = FocusNode(); // どのnodeにfocus入っているか textcontroller
  Uint8List? image;

  void handleFocus(int value) {
    if (value == nodeId! && isSelected == false) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  _NoduloState(
    this.nodeId,
    this.title,
    this.isBold,
    this.isItalic,
    this.isStripe,
    this.color,
    this.selectedNode,
    this.setSelectedNode,
    this.createSon,
    this.createBro,
    this.controller,
    this.deleteNode,
    this.titleId,
    this.image,
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setSelectedNode(nodeId);
        // textfieldのfocusを外す
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onLongPress: () {
        setSelectedNode(nodeId);
      },
      child: ValueListenableBuilder(
        valueListenable: selectedNode,
        builder: (BuildContext context, int value, Widget? child) {
          handleFocus(value);
          return Column(children: <Widget>[
            // 最初のnode
            isFirst
                ? StartingNodeWidget(titleId, title, isSelected, selectedNode,
                    setSelectedNode, nodeId, myFocusNode)
                : CommonNodeWidget(
                    isSelected,
                    isFirst,
                    selectedNode,
                    setSelectedNode,
                    nodeId,
                    myFocusNode,
                    titleId,
                    title,
                    image,
                    isBold,
                    isItalic,
                    isStripe,
                    color,
                  ),
            isSelected
                ? isFirst
                    ? NodeOptionsWidget(
                        createSon, createBro, deleteNode, myFocusNode, true)
                    : NodeOptionsWidget(
                        createSon, createBro, deleteNode, myFocusNode, false)
                : const Column(),
          ]);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (nodeId == 1) {
      isFirst = true;
    }
    setSelectedNode(nodeId);
    myFocusNode.requestFocus();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }
}
