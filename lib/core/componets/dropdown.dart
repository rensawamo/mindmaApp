import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/extension/color.dart';

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
                      color:
                          ColorExtension.getColorFromChoice(value.toString()),
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
