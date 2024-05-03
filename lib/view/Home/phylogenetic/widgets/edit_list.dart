import 'package:flutter/material.dart';
import 'package:mindmapapp/core/componets/dropdown.dart';
import 'package:mindmapapp/core/componets/select_box.dart';

// Noneの Editボタンをおしたときに popover で表示される画面
class MyDropdownScreen extends StatefulWidget {
  const MyDropdownScreen({Key? key}) : super(key: key);

  @override
  State<MyDropdownScreen> createState() => _MyDropdownScreenState();
}

class _MyDropdownScreenState extends State<MyDropdownScreen> {
  String selectedDay = '黒';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      // デザインの選択
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          // 色の選択
          GenericDropdownButton<String>(
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
        ],
      ),
    ));
  }
}
