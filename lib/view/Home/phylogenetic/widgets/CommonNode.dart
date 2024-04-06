import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../DB/local_strage/sqlite/node_db.dart';
import '../../../../view_model/Home/phylogenetic/Phylogenetic_view_model.dart';

// 各nodeの共通部分
class CommonNode extends ConsumerStatefulWidget {
  bool isSelected; // 各nodeが選択されているかどうか
  ValueNotifier<int?> selectedNode; // 
  Function setSelectedNode; // 選択されたnodeをセットする関数
  int? nodeId; // 各nodeのid
  int titleId; // 各nodeのtitleのid
  String title; // 各nodeのtitle
  var myFocusNode;

  CommonNode(this.isSelected, this.selectedNode, this.setSelectedNode,
      this.nodeId, this.myFocusNode, this.titleId,this.title);

  @override
  _StartingNodeState createState() => _StartingNodeState();
}

// 各nodeのtitleをセット
class _StartingNodeState extends ConsumerState<CommonNode> {
  final viewModel = ChangeNotifierProvider((ref) => PhylogeneticViewModel());
  TextEditingController _titleController = TextEditingController();


  @override
  void initState() {
    super.initState();
    Future(() async {
      final nodeText = widget.title!;
      _titleController.text = nodeText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(200),
          borderRadius: BorderRadius.circular(10),
          border: widget.isSelected
              ? Border.all(width: 3, color: Colors.amber)
              : Border.all(width: 2, color: Colors.lightBlue.shade200),
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
                controller: _titleController,
                onChanged: (String value) {
                  NodeData.updateNodeText(
                      widget.nodeId!, widget.titleId, value);
                },
                focusNode: widget.myFocusNode,
                onTap: () {
                  widget.setSelectedNode(widget.nodeId);
                },
                maxLines: null,
                decoration: InputDecoration(
                  focusColor: Colors.amber,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
