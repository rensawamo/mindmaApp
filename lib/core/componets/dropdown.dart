import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

// Generic Dropdown Button Widget
class GenericDropdownButton<T> extends StatefulWidget {
  final T selectedValue;
  final String Function(T) getLabel;
  final void Function(T?) onSelected;
  final List<T> items;

  const GenericDropdownButton({
    Key? key,
    required this.selectedValue,
    required this.getLabel,
    required this.onSelected,
    required this.items,
  }) : super(key: key);

  @override
  _GenericDropdownButtonState<T> createState() =>
      _GenericDropdownButtonState<T>();
}

class _GenericDropdownButtonState<T> extends State<GenericDropdownButton<T>> {
  late T currentValue;

// Enumの値に基づいてColorを返す
// 関数の種類が増えたら 専用のclassを作成
  Color getColorFromChoice(String color) {
    switch (color) {
      case "黒":
        return Colors.black;
      case "赤":
        return Colors.red;
      case "青":
        return Colors.blue;
      case "黄色":
        return Colors.yellow;
      case "オレンジ":
        return Colors.orange;
      case "緑":
        return Colors.green;
      default:
        return Colors.grey; // default color
    }
  }

  @override
  void initState() {
    super.initState();
    currentValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("色", style: AppTexts.caption3),
          SizedBox(height: context.mediaQueryHeight * .01),
          DropdownButton<T>(
            value: currentValue,
            items: widget.items.map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Center(
                  child: Text(
                    widget.getLabel(value),
                    style: TextStyle(
                      color: getColorFromChoice(value.toString()),
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (T? value) {
              if (value != null) {
                setState(() {
                  currentValue = value;
                });
                widget.onSelected(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
