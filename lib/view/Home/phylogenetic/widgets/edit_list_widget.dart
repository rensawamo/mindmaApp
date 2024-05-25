import 'package:flutter/material.dart';
import 'package:mindmapapp/core/componets/dropdown.dart';
import 'package:mindmapapp/core/componets/select_box.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/widget/camera_widget.dart';
import 'package:mindmapapp/core/widget/comfirm_dialog.dart';
import 'package:mindmapapp/db/sqlite/node_db.dart';

// Noneの Editボタンをおしたときに popover で表示される画面
class EditListWidget extends StatefulWidget {
  bool isShowingImage;
  Function updateTitle; // タイトル
  Function updateImage; // 写真
  Function updateDesign; // デザイン
  Function updateColor; // 色
  final int? nodeId;
  final int titleId;
  bool isBold;
  bool isItalic;
  bool isStripe;
  String color;
  EditListWidget(
      this.isShowingImage,
      this.updateTitle,
      this.updateImage,
      this.updateDesign,
      this.updateColor,
      this.nodeId,
      this.titleId,
      this.isBold,
      this.isItalic,
      this.isStripe,
      this.color,
      {Key? key})
      : super(key: key);

  @override
  State<EditListWidget> createState() => _EditListWidgetState();
}

class _EditListWidgetState extends State<EditListWidget> {
  String selectedColor = '黒';

  @override
  void initState() {
    super.initState();
    selectedColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      // デザインの選択
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
          SelectBox<String>(
            items: [
              'B',
              'I',
              'T',
            ],
            initiallySelected: [
              widget.isBold ? 'B' : '',
              widget.isItalic ? 'I' : '',
              widget.isStripe ? 'T' : '',
            ],
            displayItem: (item) => item,
            onSelectionChanged: (List<String> selected) {
              // 選択されたデザインを更新
              widget.updateDesign(selected);
              // Nodeのデザインを DBに保存
              NodeData.updateNodeDesign(
                widget.nodeId!,
                widget.titleId,
                selected.contains("B") ? 1 : 0,
                selected.contains("I") ? 1 : 0,
                selected.contains("T") ? 1 : 0,
              );
            },
          ),
          SizedBox(height: context.mediaQueryHeight * .025),

          // 色の選択
          Container(
            width: context.mediaQueryWidth * .4,
            child: GenericDropdownButton<String>(
              selectedValue: selectedColor,
              items: [
                "黒",
                '赤',
                '青',
                '黄色',
                'オレンジ',
                '緑',
              ],
              getLabel: (item) => item,
              onSelected: (String? value) {
                if (value != null) {
                  // 選択された色を更新
                  widget.updateColor(value);
                  // Nodeの色を DBに保存
                  NodeData.updateNodeColor(
                      widget.nodeId!, widget.titleId, value);
                  setState(() {
                    // poper の select colorの更新
                    selectedColor = value;
                  });
                }
              },
            ),
          ),
          SizedBox(height: context.mediaQueryHeight * .025),

          // カメラ or ギャラリー
          Container(
            color: Colors.white,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    widget.isShowingImage
                        ? ShowConfirmDialog(context, "テキストに変更")
                            .then((String? result) async {
                            if (result != null) {
                              await NodeData.updateNodeText(
                                  widget.nodeId!, widget.titleId, result);
                              widget.updateTitle(result);
                              Navigator.of(context).pop(result);
                            }
                          })
                        : ShowCameraDialog(context).then((value) async {
                            if (value != null) {
                              await NodeData.updateNodeImage(
                                  widget.nodeId!, widget.titleId, value);
                              widget.updateImage(value);
                              Navigator.pop(context); // dialogを閉じる
                            }
                          });
                  },
                  child: Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.leafColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        widget.isShowingImage
                            ? Icons.edit
                            :
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
