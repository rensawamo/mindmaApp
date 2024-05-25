import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:mindmapapp/core/design/view+extention.dart';
import 'package:mindmapapp/core/widget/comfirm_dialog.dart';

class CameraDialogWidget extends StatefulWidget {
  const CameraDialogWidget({Key? key}) : super(key: key);

  @override
  State<CameraDialogWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraDialogWidget> {
  // 画像をギャラリーから選ぶ関数
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // 画像がnullの場合戻る
      if (image == null) return;
      List<int> imageBytes = await image.readAsBytes();
      Uint8List imageData = Uint8List.fromList(imageBytes);

      Navigator.of(context).pop(imageData);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // カメラを使う関数
  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      // 画像がnullの場合戻る
      if (image == null) return;
      List<int> imageBytes = await image.readAsBytes();
      Uint8List imageData = Uint8List.fromList(imageBytes);

      Navigator.of(context).pop(imageData);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
            height: context.mediaQueryHeight * .1,
            width: context.mediaQueryWidth * .3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: context.mediaQueryWidth * .4,
                  color: AppColors.darkGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    "ギャラリーから選択",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    pickImage();
                  },
                ),
                // MaterialButton(
                //   minWidth: context.mediaQueryWidth * .4,
                //   color: AppColors.darkGreen,
                //   child: const Text(
                //     "カメラで撮影",
                //     style: TextStyle(
                //         color: Colors.white, fontWeight: FontWeight.bold),
                //   ),
                //   onPressed: () {
                //     pickImageC();
                //   },
                // ),
              ],
            )));
  }
}

// 写真選択から かえって値を呼び出し側のwidgetに返す
Future<Uint8List?> ShowCameraDialog(BuildContext context) async {
  Uint8List? result = await showDialog(
    context: context,
    builder: (BuildContext context) => CameraDialogWidget(),
  );
  return result;
}
