import 'dart:ffi';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:uuid/uuid.dart';
import 'dart:convert' as convert;


Future<Database> _getEdgeDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'edge.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE edge(fromId INTEGER, title TEXT, toId INTEGER)',
      );
    },
    version: 1,
  );
  return db;
}

class EdgeData {
  static Future<List<Map<String, int>>?> loadEdgeds(String title) async {
    // ロードマップの最初のedgeのタイトルでテーブル検索
    List<Map<String, int>>? json = [];
    final db = await _getEdgeDatabase();
    final datas = await db.query('edge', where: 'title = ?', whereArgs: [title]);
    print(datas);
    print("datas");
    if (datas.isNotEmpty) {
      for (var data in datas) {
        json.add({"from": data["fromId"] as int, "to": data["toId"] as int});
      }
    }
    return json;
  }

  // 新しい jsonへ切り替え
  static addEdge(String title, List<dynamic> edges) async {
    print(edges);
    final db = await _getEdgeDatabase();
    await db.delete(
      'edge',
      where: 'title = ?',
      whereArgs: [title],
    );
    for (var edge in edges) {
      db.insert('edge', {
        'fromId': edge['from'],
        'title': title,
        'toId': edge['to'],
      });
    }
  }
}
