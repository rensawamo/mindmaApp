import 'package:flutter/material.dart';

import 'StartingNode.dart';
import 'CommonNode.dart';
import 'NodeOptions.dart';

class Nodulo extends StatefulWidget {
  final int titleId; // startNodeの id
  final String title; // startNode の title
  int? nodeId;
  ValueNotifier<int> selectedNode;
  final Function setSelectedNode;
  final createSon;
  final createBro;
  final controller;


  Nodulo(this.nodeId, this.title, this.selectedNode, this.setSelectedNode,
      this.createSon, this.createBro, this.controller, this.titleId);

  @override
  State<Nodulo> createState() => _NoduloState(nodeId, title, selectedNode,
      setSelectedNode, createSon, createBro, controller,titleId);
}

class _NoduloState extends State<Nodulo> {
  final int titleId; // startNodeの id
  final String title; // startNode の title
  int? nodeId;
  ValueNotifier<int> selectedNode;
  final Function setSelectedNode;
  final createSon;
  final createBro;
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

  _NoduloState(this.nodeId, this.title, this.selectedNode, this.setSelectedNode,
      this.createSon, this.createBro, this.controller, this.titleId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setSelectedNode(nodeId);
      },
      onLongPress: () {
        setSelectedNode(nodeId);
      },
      child: ValueListenableBuilder(
        valueListenable: selectedNode,
        builder: (context, value, child) {
          handleFocus(value);
          return Column(children: [
            isFirst
                ? StartingNode(titleId,title,isSelected, selectedNode, setSelectedNode,
                nodeId,  myFocusNode)
                : CommonNode(isSelected, selectedNode, setSelectedNode, nodeId,
                    myFocusNode,titleId,title),
            isSelected
                ? isFirst
                    ? NodeOptions(createSon, createBro, true)
                    : NodeOptions(createSon, createBro, false)
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
