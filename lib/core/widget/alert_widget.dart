import 'dart:async';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  final String title;

  const ConfirmDialog({
    required this.title, Key? key,
  }) : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _controller,
            // TextFieldの設定...
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // OpacityでTextButtonをラップ
        Opacity(
          opacity: _controller.text.isNotEmpty ? 1.0 : 0.5,
          child: TextButton(
            onPressed: _controller.text.isNotEmpty
                ? () => Navigator.of(context).pop(_controller.text)
                : null,
            child: const Text('OK'), // TextFieldが空の場合はnullを設定
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateState);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateState);
    _controller.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }
}

// textfield に入力されれた文字を Okがおされた 時に。呼び出し側で関数の処理をおこなう
Future<String?> ShowConfirmDialog(BuildContext context, String title) async {
  String? result = await showDialog<String>(
    context: context,
    builder: (BuildContext context) => ConfirmDialog(
      title: title,
    ),
  );
  return result;
}
