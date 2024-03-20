import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/Home/phylogenetic/Phylogenetic_view_model.dart';
import '../view_model/local_strage/sqlite/title_list_db.dart';

class StartingNode extends ConsumerStatefulWidget {
  final int titleId;
  final String title;
  final bool isSelected;
  final ValueNotifier<int?> selectedNode;
  final Function setSelectedNode;
  final int? nodeId;
  final FocusNode myFocusNode;

  StartingNode(
      this.titleId,
      this.title,
      this.isSelected,
      this.selectedNode,
      this.setSelectedNode,
      this.nodeId,
      this.myFocusNode, {
    Key? key,
  }) : super(key: key);

  @override
  _StartingNodeState createState() => _StartingNodeState();
}

class _StartingNodeState extends ConsumerState<StartingNode> {
  final viewModel = ChangeNotifierProvider((ref) => PhylogeneticViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20), // 内側から paddingをかけられる
      width: 250,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          border: widget.isSelected
              ? Border.all(width: 3, color: Colors.amber)
              : Border.all(width: 2, color: Colors.red.shade900),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(60),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              width: 20,
              height: 20,
              margin: EdgeInsets.only(right: 10),
            ),
          ),
          Expanded(
            flex: 5,
            child: TextFormField(
                onChanged: (String value) {
                  TitleListData.updateTitle(value,widget.titleId);
                },
                focusNode: widget.myFocusNode,
                onTap: () {
                  ref.read(viewModel).
                  setSelectedNode(widget.nodeId);
                  setState(() {
                  });
                },
                maxLines: null,
                decoration: InputDecoration(
                  focusColor: Colors.amber,
                  contentPadding: EdgeInsets.all(0),
                  hintText: widget.title,
                  border: InputBorder.none,
                ),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
