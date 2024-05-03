import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/edit_list.dart';
import 'package:popover/popover.dart';

// 各nodeの共通部分
class CommonNodeWidget extends StatefulWidget {
  final bool isSelected; // 各nodeが選択されているかどうか
  final bool isFirst;
  final ValueNotifier<int?> selectedNode; //
  final Function setSelectedNode; // 選択されたnodeをセットする関数
  final int? nodeId; // 各nodeのid
  final int titleId; // 各nodeのtitleのid
  final String title; // 各nodeのtitle
  final FocusNode myFocusNode;
  final Uint8List? image; // 写真

  const CommonNodeWidget(
      this.isSelected,
      this.isFirst,
      this.selectedNode,
      this.setSelectedNode,
      this.nodeId,
      this.myFocusNode,
      this.titleId,
      this.title,
      this.image,
      {super.key});

  @override
  _StartingNodeState createState() => _StartingNodeState();
}

// 各nodeのtitleをセット
class _StartingNodeState extends State<CommonNodeWidget> {
  final TextEditingController _titleController = TextEditingController();
  Uint8List? image;
  void updateImage(Uint8List? newImage) {
    setState(() {
      image = newImage;
    });
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      final String nodeText = widget.title;
      setState(() {
        _titleController.text = nodeText;
        image = widget.image;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      // 画像 or 文字
      image != null
          ? Container(
              // 最大幅と最大高さを設定
              width: 300,
              height: 300,
              child: Image.memory(
                image!,
                fit: BoxFit.contain, // 画像のアスペクト比を保持
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              width: _titleController.text.length < 10
                  ? context.mediaQueryWidth * .54
                  : context.mediaQueryWidth * .67,
              height: context.mediaQueryHeight * .11,
              decoration: BoxDecoration(
                  color: AppColors.leafColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                  border: widget.isSelected
                      ? Border.all(
                          width: 3, color: AppColors.darkGreen.withOpacity(0.3))
                      : Border.all(
                          width: 2,
                          color: AppColors.leafColor.withOpacity(0.9)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withAlpha(330),
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ]),
            ),

      // タイトルnode か 子供nodeか
      widget.isSelected
          ? Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  // テキストをカスタマイズするpopupを表示
                  showPopover(
                    context: context,
                    bodyBuilder: (context) => MyDropdownScreen(updateImage),
                    direction: PopoverDirection.bottom,
                    width: 200,
                    height: 400,
                    arrowHeight: 15,
                    arrowWidth: 30,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: widget.isFirst
                        ? AppColors.rootColor
                        : AppColors.nodeIconColor,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(Icons.more_horiz, color: Colors.white),
                ),
              ))
          : Container(),
    ]));
  }
}
