import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

// Generic tag selection widget
class SelectBox<T> extends StatefulWidget {
  final List<T> items; // タグのリスト
  final List<T> initiallySelected; // 初期選択状態のタグ
  final String Function(T) displayItem; // アイテムを表示するための関数
  final void Function(List<T>) onSelectionChanged; // 選択が変わった時のコールバック

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

// 複数のタグを選択するためのウィジェット
// callbackで選択されたタグを返す
class _SelectBoxState<T> extends State<SelectBox<T>> {
  late List<T> selectedTags;

  @override
  void initState() {
    super.initState();
    selectedTags = List.of(widget.initiallySelected);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("デザイン", style: AppTexts.caption3),
          SizedBox(height: context.mediaQueryHeight * .01),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
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
                    widget.onSelectionChanged(List.of(selectedTags));
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    border: Border.all(
                        color: isSelected
                            ? AppColors.leafColor
                            : Colors.grey.shade100,
                        width: 2),
                    color:
                        isSelected ? AppColors.leafColor : Colors.grey.shade100,
                  ),
                  child: Text(
                    widget.displayItem(tag),
                    style: TextStyle(
                      decoration:
                          tag == "T" ? TextDecoration.lineThrough : null,
                      fontStyle:
                          tag == "I" ? FontStyle.italic : FontStyle.normal,
                      color: isSelected ? Colors.white : AppColors.leafColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
