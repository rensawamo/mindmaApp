import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/widget/pinch_zoom_widget.dart';

class ExpandImagePage extends StatefulWidget {
  final Uint8List image;
  const ExpandImagePage({Key? key, required this.image}) : super(key: key);

  @override
  State<ExpandImagePage> createState() => _ExpandImagePageState();
}

class _ExpandImagePageState extends State<ExpandImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appbarColor,
      ),
      body: Center(
        child: PinchZoomWidget(
          child: Image.memory(
            widget.image!,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
