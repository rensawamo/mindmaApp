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

  static Future<List<Map<String, dynamic>>?> loadNodes(String title) async {
    // ロードマップの最初のedgeのタイトルでテーブル検索
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

  // 新しい jsonへ切り替え
  static addNodes(String title, List<Map<String, dynamic>> nodes) async {
    final db = await _getNodeDatabase();
    await db.delete(
      'node',
      where: 'title = ?',
      whereArgs: [title],
    );
    for (var node in nodes) {
      db.insert('node', {
        'id': node['id'],
        'title': title,
        'label': node['label'],
      });
    }
  }
}
