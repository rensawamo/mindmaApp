import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindmapapp/view_model/Home/phylogenetic/Phylogenetic_view_model.dart';
import 'package:mindmapapp/db/sqlite/node_db.dart';

// 各nodeの共通部分
class CommonNodeWidget extends ConsumerStatefulWidget {
  final bool isSelected; // 各nodeが選択されているかどうか
  final ValueNotifier<int?> selectedNode; // 
  final Function setSelectedNode; // 選択されたnodeをセットする関数
  final int? nodeId; // 各nodeのid
  final int titleId; // 各nodeのtitleのid
  final String title; // 各nodeのtitle
  final FocusNode myFocusNode;

  const CommonNodeWidget(this.isSelected, this.selectedNode, this.setSelectedNode,
      this.nodeId, this.myFocusNode, this.titleId,this.title, {super.key});

  @override
  _StartingNodeState createState() => _StartingNodeState();
}

// 各nodeのtitleをセット
class _StartingNodeState extends ConsumerState<CommonNodeWidget> {
  final ChangeNotifierProvider<PhylogeneticViewModel> viewModel = ChangeNotifierProvider((ChangeNotifierProviderRef<Object?> ref) => PhylogeneticViewModel());
  final TextEditingController _titleController = TextEditingController();


  @override
  void initState() {
    super.initState();
    Future(() async {
      final String nodeText = widget.title;
      _titleController.text = nodeText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(200),
          borderRadius: BorderRadius.circular(10),
          border: widget.isSelected
              ? Border.all(width: 3, color: Colors.amber)
              : Border.all(width: 2, color: Colors.lightBlue.shade200),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withAlpha(60),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
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
                decoration: const InputDecoration(
                  focusColor: Colors.amber,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
