import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

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

  static Future<void> addEdge(int fromId, int titleID, int toId) async {
    final db = await _getEdgeDatabase();
    db.insert('edge', {
      'fromId': fromId,
      'titleID': titleID,
      'toId': toId,
    });
  }

  static Future<void> deleteEdge(int titleID,int toId) async {
    final db = await _getEdgeDatabase();
    db.delete('edge',
        where: 'titleID = ? AND toId = ?',
        whereArgs: [titleID, toId]);
  }
}
