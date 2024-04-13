import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindmapapp/view_model/Home/phylogenetic/Phylogenetic_view_model.dart';
import 'package:mindmapapp/db/sqlite/node_db.dart';
import 'package:mindmapapp/db/sqlite/title_list_db.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

class StartingNodeWidget extends ConsumerStatefulWidget {
  final int titleId;
  final String title;
  final bool isSelected;
  final ValueNotifier<int?> selectedNode;
  final Function setSelectedNode;
  final int? nodeId;
  final FocusNode myFocusNode;

  const StartingNodeWidget(
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
  final ChangeNotifierProvider<PhylogeneticViewModel> viewModel =
      ChangeNotifierProvider(
          (ChangeNotifierProviderRef<Object?> ref) => PhylogeneticViewModel());
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
      padding: const EdgeInsets.all(10), 
      width: context.mediaQueryWidth * .56,
      height: context.mediaQueryHeight * .11,
      decoration: BoxDecoration(
          color: AppColors.rootColor.withAlpha(200),
          borderRadius: BorderRadius.circular(10),
          border: widget.isSelected
              ? Border.all(width: 3, color: AppColors.treeColor)
              : Border.all(width: 2, color: AppColors.rootColor),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.rootColor.withAlpha(60),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: TextFormField(
                controller: _titleController,
                onChanged: (String value) {
                  // listの titleを更新する
                  TitleListData.updateTitle(value, widget.titleId);
                  // nodeのdbを更新する
                  NodeData.updateNodeText(
                      widget.nodeId!, widget.titleId, value);
                },
                focusNode: widget.myFocusNode,
                onTap: () {
                  widget.setSelectedNode(widget.nodeId);
                  setState(() {});
                },
                maxLines: null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
