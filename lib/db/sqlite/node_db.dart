import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';


Future<Database> _getNodeDatabase() async {
  final String dbPath = await sql.getDatabasesPath();
  final sql.Database db = await sql.openDatabase(
    path.join(dbPath, 'node.db'),
    onCreate: (sql.Database db, int version) {
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
    List<Map<String, dynamic>>? json = <Map<String, dynamic>>[];
    final sql.Database db = await _getNodeDatabase();
    final List<Map<String, Object?>> datas = await db.query('node', where: 'titleID = ?', whereArgs: <Object?>[titleID], orderBy: 'id ASC');
    if (datas.isNotEmpty) {
      for (Map<String, Object?> data in datas) {
        json.add({"id": data["id"], "label": data["label"]});
      }
    }
    return json;
  }

  // node追加処理
  static Future<void> addNode(int id, int titleID, String label) async {
    final sql.Database db = await _getNodeDatabase();
    List<Map<String, Object?>> existingNode = await db.query(
      'node',
      where: 'id = ? AND titleID = ?',
      whereArgs: <Object?>[id,titleID],
    );
    // 最初にデフォルトのノードを登録する
    if (existingNode.isNotEmpty) {
      print('ID $id is already in the database.');
      return;
    }
    await db.insert('node', <String, Object?>{
      'id': id,
      'titleID': titleID,
      'label': label,
    });
    print('Node with ID $id added.');
  }

  // Nodeのlabelを更新
  static updateNodeText(int nodeId, int titleId, String text) async {
    final sql.Database db = await _getNodeDatabase();
    await db.update(
      'node',
      <String, Object?>{'label': text},
      where: 'id = ? AND titleID = ?',
      whereArgs: <Object?>[nodeId, titleId],
    );
  }

  //  Node削除
  static Future deleteNode(int titleID, int nodeId) async {
    final sql.Database db = await _getNodeDatabase();
    db.delete('node', where: 'id = ? AND titleID = ?', whereArgs: <Object?>[nodeId, titleID]);
  }
}
