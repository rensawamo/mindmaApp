import 'package:flutter/material.dart';
import 'package:mindmapapp/core/componets/dropdown.dart';


// Noneの Editボタンをおしたときに popover で表示される画面
class MyDropdownScreen extends StatefulWidget {
  const MyDropdownScreen({Key? key}) : super(key: key);

  @override
  State<MyDropdownScreen> createState() => _MyDropdownScreenState();
}

class _MyDropdownScreenState extends State<MyDropdownScreen> {
  String selectedDay = '月曜日';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: GenericDropdownButton<String>(
          selectedValue: selectedDay,
          items: ['月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日', '日曜日'],
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
    );
  }
}
