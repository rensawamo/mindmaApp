import 'dart:ffi';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert' as convert;

Future<Database> _getTitleListDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'titleList.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE titleList(id INTEGER PRIMARY KEY AUTOINCREMENT,sortId INTEGER, title TEXT)',
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
    List<String> titles = [];
    final db = await _getTitleListDatabase();
    final datas = await db.query('titleList', orderBy: 'sortId ASC');
    if (datas.isNotEmpty) {
      for (var data in datas) {
        titles.add(data["title"] as String);
      }
    }
    return titles;
  }

  static Future<int> getId(String title) async {
    // マインドマップのタイトル
    final db = await _getTitleListDatabase();
    final datas = await db.query('titleList', where: 'title = ?', whereArgs: [title]);
    return datas[0]["id"] as int;
  }

  // タップされたリストの titleを取得 (系統樹の最初)
  static Future<String> getStartTitle(int id) async {
    final db = await _getTitleListDatabase();
    final data = await db.query('titleList', where: 'id = ?', whereArgs: [id]);
    return data[0]['title'] as String;
  }

  //

  // DB追加処理
  static addTitle(String title,int sortId) async {
    final db = await _getTitleListDatabase();
    var existingNode = await db.query(
      'titleList',
      where: 'sortId = ?',
      whereArgs: [sortId],
    );
    // 最初にデフォルトのノードを登録する
    if (existingNode.isNotEmpty) {
      print('ID $sortId is already in the database.');
      return;
    }
    db.insert('titleList', {
      'title': title,
      'sortId': sortId,
    });
  }

  static sortChange(List<String> titleLists) async {
    final db = await _getTitleListDatabase();
    // sortNum
    for (int i = 1; i < titleLists.length; i++){
      await db.update(
        'titleList',
        {
          'title': titleLists[i - 1],
          'id': getId(titleLists[i - 1])
        },
        where: 'sortId = ?',
        whereArgs: [i],
      );
    }
  }
}
