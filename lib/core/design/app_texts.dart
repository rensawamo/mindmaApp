import 'package:flutter/material.dart';

class AppTexts {
  // ランチスクリーンや特大タイトルに使用するテキストスタイル
  static const TextStyle launch = TextStyle(
    fontSize: 40.0,
    color: Color.fromARGB(255, 21, 105, 84), // 深い緑色
    fontWeight: FontWeight.bold,
  );

  // ページタイトルなどに使用する基本的なタイトルスタイル
  static const TextStyle title = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  );

  // サブタイトルやセクションタイトルに使用するスタイル
  static const TextStyle title2 = TextStyle(
    fontSize: 25.0,
    color: Color.fromARGB(255, 21, 105, 84), // 深い緑色
    fontWeight: FontWeight.bold,
  );

  // 小さめのセクションタイトルに使用
  static const TextStyle title3 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  // 補助的なタイトルや説明に使用する少し小さめのテキストスタイル
  static const TextStyle title4 = TextStyle(
    fontSize: 17,
  );

  // キャプションや注意書きに使用するテキストスタイル
  static const TextStyle caption = TextStyle(
    fontSize: 18.0,
    color: Color.fromARGB(255, 78, 50, 110), // 暗い紫色
  );

  // より小さなキャプションや補足情報に使用
  static const TextStyle caption2 = TextStyle(
    fontSize: 14.0,
    color: Colors.grey,
  );

  // 一般的な説明文や本文に使用するスタイル
  static const TextStyle caption3 = TextStyle(
    fontSize: 16.0,
    color: Color.fromARGB(255, 0, 0, 0), // 真っ黒
  );

  // 本文や段落に使用する標準的なボディテキストスタイル
  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  // エラーメッセージに使用するテキストスタイル
  static const TextStyle error = TextStyle(
    fontSize: 14.0,
    color: Color.fromARGB(255, 165, 80, 87), // 淡い赤色
  );

  // 特定のUI要素でテキストを透明にするために使用
  static const TextStyle transparent = TextStyle(
    fontSize: 16.0,
    color: Colors.transparent,
  );
}
