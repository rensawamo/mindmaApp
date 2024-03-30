import 'dart:ffi';
import 'package:mindmapapp/DB/local_strage/sqlite/title_list_db.dart';
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
        'CREATE TABLE edge(fromId INTEGER, titleID INTEGER, toId INTEGER)',
      );
    },
    version: 1,
  );
  return db;
}

class EdgeData {
  // 画面描写時に取得
  static Future<List<Map<String, int>>?> loadEdgeds(int titleID) async {
    List<Map<String, int>>? json = [];
    final db = await _getEdgeDatabase();
    final datas =
        await db.query('edge', where: 'titleID = ?', whereArgs: [titleID]);
    if (datas.isNotEmpty) {
      for (var data in datas) {
        json.add({"from": data["fromId"] as int, "to": data["toId"] as int});
      }
    }
    return json;
  }

  static addEdge(int fromId, int titleID, int toId) async {
    final db = await _getEdgeDatabase();
    db.insert('edge', {
      'fromId': fromId,
      'titleID': titleID,
      'toId': toId,
    });
  }
}
