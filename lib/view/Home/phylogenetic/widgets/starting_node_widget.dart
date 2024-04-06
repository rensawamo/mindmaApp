import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindmapapp/view_model/Home/phylogenetic/Phylogenetic_view_model.dart';
import 'package:mindmapapp/db/sqlite/node_db.dart';
import 'package:mindmapapp/db/sqlite/title_list_db.dart';

class StartingNodeWidget extends ConsumerStatefulWidget {
  final int titleId;
  final String title;
  final bool isSelected;
  final ValueNotifier<int?> selectedNode;
  final Function setSelectedNode;
  final int? nodeId;
  final FocusNode myFocusNode;

  StartingNodeWidget(
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

class _StartingNodeState extends ConsumerState<StartingNodeWidget> {
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
                controller: _titleController,
                onChanged: (String value) {
                  // listの titleを更新する
                  TitleListData.updateTitle(value,widget.titleId);
                  // nodeのdbを更新する
                  NodeData.updateNodeText(
                      widget.nodeId!, widget.titleId, value);
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
                  border: InputBorder.none,
                ),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
