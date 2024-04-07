import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getEdgeDatabase() async {
  final String dbPath = await sql.getDatabasesPath();
  final sql.Database db = await sql.openDatabase(
    path.join(dbPath, 'edge.db'),
    onCreate: (sql.Database db, int version) {
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
    List<Map<String, int>>? json = <Map<String, int>>[];
    final sql.Database db = await _getEdgeDatabase();
    final List<Map<String, Object?>> datas =
        await db.query('edge', where: 'titleID = ?', whereArgs: <Object?>[titleID]);
    if (datas.isNotEmpty) {
      for (Map<String, Object?> data in datas) {
        json.add(<String, int>{"from": data["fromId"] as int, "to": data["toId"] as int});
      }
    }
    return json;
  }

  static Future<void> addEdge(int fromId, int titleID, int toId) async {
    final sql.Database db = await _getEdgeDatabase();
    db.insert('edge', <String, Object?>{
      'fromId': fromId,
      'titleID': titleID,
      'toId': toId,
    });
  }

  static Future<void> deleteEdge(int titleID,int toId) async {
    final sql.Database db = await _getEdgeDatabase();
    db.delete('edge',
        where: 'titleID = ? AND toId = ?',
        whereArgs: <Object?>[titleID, toId]);
  }
}
