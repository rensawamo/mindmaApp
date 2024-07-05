import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/extension/color.dart';
import 'package:mindmapapp/db/sqlite/node_db.dart';
import 'package:mindmapapp/view/Home/phylogenetic/expand_image_page.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/edit_list_widget.dart';

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
  final bool isBold;
  final bool isItalic;
  final bool isStripe;
  final String color;

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
      this.isBold,
      this.isItalic,
      this.isStripe,
      this.color,
      {super.key});

  @override
  _StartingNodeState createState() => _StartingNodeState();
}

// 各nodeのtitleをセット
class _StartingNodeState extends State<CommonNodeWidget> {
  final TextEditingController _titleController = TextEditingController();
  Uint8List? image;
  late String title;
  late bool isBold;
  late bool isItalic;
  late bool isStripe;
  late String selectColor;

  // Bold isItalic isUnderline
  List<String> selectedDesigns = <String>['', '', ''];

  // poperの イメージセレクトの callback関数でこちらのwidgetの imageを更新
  void updateImage(Uint8List? newImage) {
    setState(() {
      image = newImage;
    });
  }

  // 写真からテキストに変換する時に titleを更新する関数
  void updateTitle(String newTitle) {
    setState(() {
      print("newTitle: $newTitle");
      image = null;
      _titleController.text = newTitle;
    });
  }

  // poperの デザインセレクトの callback関数でこちらのwidgetの textを更新
  void updateDesign(List<String> newDesigns) {
    setState(() {
      selectedDesigns = newDesigns;
      isBold = selectedDesigns.contains("B");
      isItalic = selectedDesigns.contains("I");
      isStripe = selectedDesigns.contains("T");
    });
  }

  // poperの カラーセレクトの callback関数でこちらのwidgetの colorを更新
  void updateColor(String newColor) {
    setState(() {
      selectColor = newColor;
    });
  }

  @override
  void initState() {
    super.initState();
    title = widget.title;
    _titleController.text = title;
    image = widget.image;
    isBold = widget.isBold;
    isItalic = widget.isItalic;
    isStripe = widget.isStripe;
    selectColor = widget.color;
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
          ? GestureDetector(
              onLongPress: () {
                // 画像を拡大
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExpandImagePage(image: image!),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                width: 150,
                height: 150,
                child: Image.memory(
                  image!,
                  fit: BoxFit.contain,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              width: context.mediaQueryWidth * .43,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            color:
                                ColorExtension.getColorFromChoice(selectColor),
                            // bold
                            fontWeight: ( isBold
                                ? FontWeight.bold
                                : FontWeight.normal),
                            // italic
                            fontStyle: ( isItalic
                                ? FontStyle.italic
                                : FontStyle.normal),
                            // 取り消し線
                            decoration: isStripe
                                ? TextDecoration.lineThrough
                                : null,
                            fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),

      // タイトルnode か 子供nodeか
      widget.isSelected
          ? Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  // テキストをカスタマイズするpopupを表示
                  // 画像と textのきりかえ
                  showPopover(
                    context: context,
                    bodyBuilder: (context) => EditListWidget(
                        image != null,
                        updateTitle,
                        updateImage,
                        updateDesign,
                        updateColor,
                        widget.nodeId!,
                        widget.titleId,
                        isBold,
                        isItalic,
                        isStripe,
                        selectColor),
                    width: context.mediaQueryWidth * .55,
                    height: context.mediaQueryHeight * .415,
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
