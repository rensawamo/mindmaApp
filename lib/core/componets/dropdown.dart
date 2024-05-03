import 'package:flutter/material.dart';

// Generic dropdown button widget.
class GenericDropdownButton<T> extends StatefulWidget {
  final T selectedValue;
  final List<T> items;
  final String Function(T) getLabel;
  final void Function(T?) onSelected;

  const GenericDropdownButton({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.getLabel,
    required this.onSelected,
  }) : super(key: key);

  @override
  _GenericDropdownButtonState<T> createState() => _GenericDropdownButtonState<T>();
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
    return DropdownButton<T>(
      value: currentValue,
      items: widget.items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(widget.getLabel(value)),
        );
      }).toList(),
      onChanged: (T? value) {
        setState(() {
          currentValue = value!;
        });
        widget.onSelected(value);
      },
    );
  }
}
