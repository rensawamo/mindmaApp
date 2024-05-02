import 'package:flutter/material.dart';

// Generic tag selection widget
class SelectBox<T> extends StatefulWidget {
  final List<T> items;  // タグのリスト
  final List<T> initiallySelected;  // 初期選択状態のタグ
  final String Function(T) displayItem;  // アイテムを表示するための関数
  final void Function(List<T>) onSelectionChanged;  // 選択が変わった時のコールバック

  const SelectBox({
    Key? key,
    required this.items,
    required this.initiallySelected,
    required this.displayItem,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<SelectBox<T>> createState() => _SelectBoxState<T>();
}

class _SelectBoxState<T> extends State<SelectBox<T>> {
  late List<T> selectedTags;

  @override
  void initState() {
    super.initState();
    selectedTags = List.of(widget.initiallySelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('複数選択できるタグ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              runSpacing: 16,
              spacing: 16,
              children: widget.items.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedTags.remove(tag);
                      } else {
                        selectedTags.add(tag);
                      }
                      widget.onSelectionChanged(List.of(selectedTags)); // Update external state
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      border: Border.all(color: isSelected ? Colors.pink : Colors.grey, width: 2),
                      color: isSelected ? Colors.pink : null,
                    ),
                    child: Text(
                      widget.displayItem(tag),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedTags.clear();
                          widget.onSelectionChanged(List.of(selectedTags)); // Update external state
                        });
                      },
                      child: const Text('クリア'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedTags = List.of(widget.items);
                          widget.onSelectionChanged(List.of(selectedTags)); // Update external state
                        });
                      },
                      child: const Text('ぜんぶ'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
