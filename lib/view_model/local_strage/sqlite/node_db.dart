import 'dart:ffi';
import 'package:mindmapapp/view_model/local_strage/sqlite/title_list_db.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:uuid/uuid.dart';
import 'dart:convert' as convert;


Future<Database> _getNodeDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'node.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE node(id INTEGER, titleID INTEGER, label TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class NodeData {
  // 画面描写でデータ取得
  static Future<List<Map<String, dynamic>>?> loadNodes(int titleID) async {
    List<Map<String, dynamic>>? json = [];
    final db = await _getNodeDatabase();
    final datas = await db.query('node', where: 'titleID = ?', whereArgs: [titleID], orderBy: 'id ASC');
    if (datas.isNotEmpty) {
      for (var data in datas) {
        json.add({"id": data["id"], "label": data["label"]});
      }
    }
    return json;
  }

  // node追加処理
  static addNode(int id, int titleID, String label) async {
    final db = await _getNodeDatabase();
    var existingNode = await db.query(
      'node',
      where: 'id = ? AND titleID = ?',
      whereArgs: [id,titleID],
    );
    // 最初にデフォルトのノードを登録する
    if (existingNode.isNotEmpty) {
      print('ID $id is already in the database.');
      return;
    }
    await db.insert('node', {
      'id': id,
      'titleID': titleID,
      'label': label,
    });
    print('Node with ID $id added.');
  }

  // Nodeのlabelを更新
  static updateNodeText(int nodeId, int titleId, String text) async {
    final db = await _getNodeDatabase();
    await db.update(
      'node',
      {'label': text},
      where: 'id = ? AND titleID = ?',
      whereArgs: [nodeId, titleId],
    );
  }
}
