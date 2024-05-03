import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapapp/core/componets/dropdown.dart';
import 'package:mindmapapp/core/componets/select_box.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/widget/camera_widget.dart';
import 'package:mindmapapp/view_model/home/phylogenetic/Phylogenetic_view_model.dart';

// Noneの Editボタンをおしたときに popover で表示される画面
class MyDropdownScreen extends StatefulWidget {
  Function updateImage; // 写真

  MyDropdownScreen(this.updateImage, {Key? key}) : super(key: key);

  @override
  State<MyDropdownScreen> createState() => _MyDropdownScreenState();
}

class _MyDropdownScreenState extends State<MyDropdownScreen> {
  String selectedDay = '黒';

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
            initiallySelected: [''],
            displayItem: (item) => item,
            onSelectionChanged: (List<String> selected) {
              setState(() {
                selectedDay = selected.first;
              });
            },
          ),
          SizedBox(height: context.mediaQueryHeight * .025),

          // 色の選択
          Container(
            width: context.mediaQueryWidth * .4,
            child: GenericDropdownButton<String>(
              selectedValue: selectedDay,
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
                  setState(() {
                    selectedDay = value;
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
                    ShowCameraDialog(context).then((value) {
                      if (value != null) {
                        Navigator.pop(context, value);
                        widget.updateImage(value);
                        print(value);
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
