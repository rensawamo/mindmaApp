import 'dart:typed_data';

import 'package:mindmapapp/model/Home/phylogenetic/node_result_model.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getNodeDatabase() async {
  final String dbPath = await sql.getDatabasesPath();
  final sql.Database db = await sql.openDatabase(
    path.join(dbPath, 'node.db'),
    onCreate: (sql.Database db, int version) {
      return db.execute(
        'CREATE TABLE node(id INTEGER, titleID INTEGER, label TEXT, image BLOB, isBold INTEGER, isItalic INTEGER, isStripe INTEGER, color String)',
      );
    },
    version: 1,
  );
  return db;
}

class NodeData {
  // 画面描写でデータ取得
  static Future<NodeResult> loadNodes(int titleID) async {
    List<Map<String, dynamic>> json = <Map<String, dynamic>>[];
    final sql.Database db = await _getNodeDatabase();
    final List<Map<String, dynamic?>> datas = await db.query('node',
        where: 'titleID = ?',
        whereArgs: <dynamic?>[titleID],
        orderBy: 'id ASC');
    int maxValue = 1;
    if (datas.isNotEmpty) {
      for (Map<String, dynamic?> data in datas) {
        json.add({
          "id": data["id"],
          "label": data["label"],
          "image": data["image"] != null && data["image"].length > 0
              ? data["image"]
              : null,
          "isBold": data["isBold"],
          "isItalic": data["isItalic"],
          "isStripe": data["isStripe"],
          "color": data["color"],
        });
        if (data["id"] as int > maxValue) {
          maxValue = data["id"] as int;
        }
      }
    }
    return NodeResult(json, maxValue);
  }

  // node追加処理
  static Future<void> addNode(int id, int titleID, String label) async {
    final sql.Database db = await _getNodeDatabase();
    List<Map<String, dynamic?>> existingNode = await db.query(
      'node',
      where: 'id = ? AND titleID = ?',
      whereArgs: <dynamic?>[id, titleID],
    );
    // 最初にデフォルトのノードを登録する
    if (existingNode.isNotEmpty && id == 1) {
      print('ID $id is already in the database.');
      return;
    }
    await db.insert('node', <String, dynamic?>{
      'id': id,
      'titleID': titleID,
      'label': label,
      'image': Uint8List(0),
      'isBold': 0,
      'isItalic': 0,
      'isStripe': 0,
      'color': '黒',
    });
  }

  // Nodeの 文字のデザインの更新
  static updateNodeDesign(
      int nodeId, int titleId, int isBold, int isItalic, int isStripe) async {
    final sql.Database db = await _getNodeDatabase();
    await db.update(
      'node',
      <String, dynamic?>{
        'isBold': isBold,
        'isItalic': isItalic,
        'isStripe': isStripe,
      },
      where: 'id = ? AND titleID = ?',
      whereArgs: <dynamic?>[nodeId, titleId],
    );
  }

  // Nodeの色の更新
  static updateNodeColor(int nodeId, int titleId, String color) async {
    final sql.Database db = await _getNodeDatabase();
    await db.update(
      'node',
      <String, dynamic?>{'color': color},
      where: 'id = ? AND titleID = ?',
      whereArgs: <dynamic?>[nodeId, titleId],
    );
  }

  // Nodeのlabelを更新
  // image のpathを削除して labelに文字を送り込む
  static updateNodeText(int nodeId, int titleId, String text) async {
    final sql.Database db = await _getNodeDatabase();
    await db.update(
      'node',
      <String, dynamic?>{'label': text , 'image': null},
      where: 'id = ? AND titleID = ?',
      whereArgs: <dynamic?>[nodeId, titleId],
    );
  }

  static updateNodeImage(int nodeId, int titleId, Uint8List? image) async {
    final sql.Database db = await _getNodeDatabase();
    await db.update(
      'node',
      <String, dynamic?>{'image': image!, 'label': ''},
      where: 'id = ? AND titleID = ?',
      whereArgs: <dynamic?>[nodeId, titleId],
    );
  }

  // Node削除
  // error か nullかで errorの場合は jsonの更新を止める
  static Future<String?> deleteNode(int titleID, int nodeId) async {
    String? error;
    final sql.Database db = await _getNodeDatabase();
    try {
      await db.delete(
        'node',
        where: 'id = ? AND titleID = ?',
        whereArgs: [nodeId, titleID],
      );
      return null;
    } catch (e) {
      return 'Error deleting node: $e';
    } finally {
      await db.close();
    }
  }

  // Nodeの最大IDを取得
  static Future<int> getMaxId(int titleId) async {
    final sql.Database db = await _getNodeDatabase();
    final List<Map<String, dynamic?>> datas = await db.query('node',
        where: 'titleID = ?',
        whereArgs: <dynamic?>[titleId],
        orderBy: 'id DESC',
        limit: 1);
    if (datas.isNotEmpty) {
      return datas.first['id'] as int; // 最初の要素のidを返す
    }
    print('No node found in the database.');
    return 1; // node 初期値
  }
}
