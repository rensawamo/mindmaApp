import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getTitleListDatabase() async {
  final String dbPath = await sql.getDatabasesPath();
  final sql.Database db = await sql.openDatabase(
    path.join(dbPath, 'titleList.db'),
    onCreate: (sql.Database db, int version) {
      return db.execute(
        'CREATE TABLE titleList(id INTEGER PRIMARY KEY AUTOINCREMENT,sortId INTEGER, title TEXT )',
      );
    },
    version: 1,
  );
  return db;
}

class TitleListData {
  // 画面描写でデータ取得
  static Future<List<String>> loadTitles() async {
    // マインドマップのタイトル
    List<String> titles = <String>[];
    final sql.Database db = await _getTitleListDatabase();
    final List<Map<String, Object?>> datas = await db.query('titleList', orderBy: 'sortId ASC');
    if (datas.isNotEmpty) {
      for (Map<String, Object?> data in datas) {
        titles.add(data["title"] as String);
      }
    }
    return titles;
  }

  // phylognetic viewで 最初のタイトルが変更された場合 DBの更新をおこなう
  static void updateTitle(String title, int titleId) async {
    final sql.Database db = await _getTitleListDatabase();
    await db.update(
      'titleList',
      <String, Object?>{'title': title},
      where: 'id = ?',
      whereArgs: <Object?>[titleId],
    );
  }

  static Future<int> selectedTitleId(String title) async {
    final sql.Database db = await _getTitleListDatabase();
    final List<Map<String, Object?>> data = await db.query('titleList', where: 'title = ?', whereArgs: <Object?>[title]);
    return data[0]['id'] as int;
  }

  // タップされたリストの titleを取得 (系統樹の最初)
  static Future<String> getStartTitle(int id) async {
    final sql.Database db = await _getTitleListDatabase();
    final List<Map<String, Object?>> data = await db.query('titleList', where: 'id = ?', whereArgs: <Object?>[id]);
    return data[0]['title'] as String;
  }

  // DB削除処理
  static deleteTitle(String title) async {
    final sql.Database db = await _getTitleListDatabase();
    // titleに一致するレコードを削除する
    await db.delete(
      'titleList',
      where: 'title = ?',
      whereArgs: <Object?>[title],
    );
  }


  // DB追加処理
  static Future<void> addTitle(String title,int sortId) async {
    final sql.Database db = await _getTitleListDatabase();
    List<Map<String, Object?>> existingNode = await db.query(
      'titleList',
      where: 'title = ?',
      whereArgs: <Object?>[title],
    );
    // 最初にデフォルトのノードを登録する
    if (existingNode.isNotEmpty) {
      print('ID $sortId is already in the database.');
      return;
    }
    db.insert('titleList', <String, Object?>{
      'title': title,
      'sortId': sortId,
    });
  }

  //  dbの並べ替え
  static Future<void> sortChange(List<int> sortIndexes) async {
    final sql.Database db = await _getTitleListDatabase();
    // 既存のレコードを sortId の昇順で取得
    final List<Map<String, Object?>> datas = await db.query('titleList', orderBy: 'sortId ASC');

    // トランザクションを開始
    await db.transaction((sql.Transaction txn) async {
      for (int i = 0; i < datas.length; i++) {
        Map<String, Object?> data = datas[i];
        int newSortId = sortIndexes[i];
        // データベースを更新
        await txn.update(
          'titleList',
          <String, Object?>{'sortId': newSortId},
          where: 'id = ?',
          whereArgs: <Object?>[data['id']],
        );
      }
    });
  }
}
