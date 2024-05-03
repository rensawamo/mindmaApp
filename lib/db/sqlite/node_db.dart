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
        'CREATE TABLE node(id INTEGER, titleID INTEGER, label TEXT)',
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
    final List<Map<String, Object?>> datas = await db.query('node',
        where: 'titleID = ?', whereArgs: <Object?>[titleID], orderBy: 'id ASC');
    int maxValue = 1;
    if (datas.isNotEmpty) {
      for (Map<String, Object?> data in datas) {
        json.add({"id": data["id"], "label": data["label"]});
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
    List<Map<String, Object?>> existingNode = await db.query(
      'node',
      where: 'id = ? AND titleID = ?',
      whereArgs: <Object?>[id, titleID],
    );
    // 最初にデフォルトのノードを登録する
    if (existingNode.isNotEmpty && id == 1) {
      print('ID $id is already in the database.');
      return;
    }
    await db.insert('node', <String, Object?>{
      'id': id,
      'titleID': titleID,
      'label': label,
    });
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
  final List<Map<String, Object?>> datas = await db.query('node',
      where: 'titleID = ?', whereArgs: <Object?>[titleId], orderBy: 'id DESC', limit: 1);
  if (datas.isNotEmpty) {
    return datas.first['id'] as int; // 最初の要素のidを返す
  }
  print('No node found in the database.');
  return 1; // node 初期値
}

  static Future<void> updateNodeId() async {
    final sql.Database db = await _getNodeDatabase();
    List<Map<String, Object?>> nodes = await db.query('node');
    for (Map<String, Object?> node in nodes) {
      await db.update(
        'node',
        <String, Object?>{'id': nodes.indexOf(node) + 1},
        where: 'id = ?',
        whereArgs: [node['id']],
      );
    }
  }
}
