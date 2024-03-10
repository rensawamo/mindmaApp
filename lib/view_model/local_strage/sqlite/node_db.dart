import 'dart:ffi';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:uuid/uuid.dart';
import 'dart:convert' as convert;

// {
// "nodes": [
// {"id": 1, "label": "Início"},
// {"id": 2, "label": "NEW NODE"},
// {"id": 3, "label": "NEW NODE"},
// {"id": 4, "label": "NEW NODE"}
// ],
// "edges": [
// {"from": 1, "to": 2},
// {"from": 1, "to": 3}, // Corrected the syntax here
//     {"from": 2, "to": 4}  // Corrected the syntax here
// ]
// }


Future<Database> _getNodeDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'node.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE node(id INTEGER, title TEXT, label TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class NodeData {

  // 画面描写でデータ取得
  static Future<List<Map<String, dynamic>>?> loadNodes(String title) async {
    List<Map<String, dynamic>>? json = [];
    final db = await _getNodeDatabase();
    final datas = await db.query('node', where: 'title = ?', whereArgs: [title], orderBy: 'id ASC');
    if (datas.isNotEmpty) {
      for (var data in datas) {
        json.add({"id": data["id"], "label": data["label"]});
      }
    }
    return json;
  }

  // node追加処理
  static addNode(int id, String title, String label) async {
    final db = await _getNodeDatabase();
    var existingNode = await db.query(
      'node',
      where: 'id = ?',
      whereArgs: [id],
    );
    // 最初にデフォルトのノードを登録する
    if (existingNode.isNotEmpty) {
      print('ID $id is already in the database.');
      return;
    }
    await db.insert('node', {
      'id': id,
      'title': title,
      'label': label,
    });
    print('Node with ID $id added.');
  }
}
