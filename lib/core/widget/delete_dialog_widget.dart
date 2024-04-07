import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mindmapapp/app.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/app_texts.dart';
import 'package:mindmapapp/core/design/view+extention.dart';

class DeleteDialog extends StatefulWidget {
  final String title;

  const DeleteDialog({
    required this.title, Key? key,
  }) : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.paleGreen,
      title: Text(widget.title,style: AppTexts.title4),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
      ),
      actions: <Widget>[
        TextButton(
          child:  Text('キャンセル',style: AppTexts.caption3),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('OK',style: AppTexts.caption3),
          onPressed: () =>  Navigator.of(context).pop(true),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

}

// ok がおされたか
Future<bool?> ShowDeleteDialog(BuildContext context,String title) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => DeleteDialog(
      title: title,
    ),
  );
  return result;
}

