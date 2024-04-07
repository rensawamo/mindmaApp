import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindmapapp/db/sqlite/title_list_db.dart';
import 'package:mindmapapp/core/componets/snackbar.dart';
import 'package:mindmapapp/core/widget/alert_widget.dart';
import 'package:mindmapapp/core/widget/delete_dialog_widget.dart';
import 'package:mindmapapp/view/Home/phylogenetic/Phylogenetic_view.dart';

class TitleListView extends ConsumerStatefulWidget {
  const TitleListView({super.key});
  @override
  ConsumerState<TitleListView> createState() => _TitleListViewState();
}

class _TitleListViewState extends ConsumerState<TitleListView> {

  // マインドマップのタイトル
  List<String> myTiles = <String>[];

  // listの変化量を追跡する
  List<int> createIndexMapping(List<String> before, List<String> after) {
    List<int> indexMapping = <int>[];
    // 各要素の変更後のインデックスを追跡
    for (String item in before) {
      int newIndex = after.indexOf(item);
      indexMapping.add(newIndex);
    }
    return indexMapping;
  }

  // list darg dropはriver pod の適応？
  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      List<String> preTitles = List<String>.from(myTiles);
      final String tile = myTiles.removeAt(oldIndex);
      myTiles.insert(newIndex, tile);
      List<int> indexMapping = createIndexMapping(preTitles, myTiles);
      TitleListData.sortChange(indexMapping);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView(
        padding: const EdgeInsets.all(10),
        onReorder: updateMyTiles,
        children: <Widget>[
          for (final String tile in myTiles)
            Padding(
              key: ValueKey(tile),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey[200],
                child: ListTile(
                  // 削除ダイアログのh表示
                  trailing: GestureDetector(
                    onTap: () async {
                      ShowDeleteDialog(context, "削除").then((bool? result) async {
                        if (result != null) {
                          //okがおされた場合
                          TitleListData.deleteTitle(tile);
                          myTiles.remove(tile);
                          setState(() {});
                        }
                      });
                    },
                    child: const Icon(Icons.delete),
                  ),
                  title: Text(tile),
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            PhylogeneticTreeView(title: tile),
                      ),
                    ).then((result) => Future.microtask(() async {
                          // phylogenetic viewで タイトルが更新されたときの対策として myTiles を更新する
                          myTiles = await TitleListData.loadTitles();
                          setState(() {});
                        }));
                  },
                ),
              ),
            ),
        ],
      ),

      //  titleの追加 ダイヤログ
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ShowConfirmDialog(context, "追加").then((String? result) async {
            if (result != null) {
              // list titleは 一意とする
              if (myTiles.contains(result)) {
                ShowErrorSnackBar(context, 'すでに登録されています');
              } else {
                TitleListData.addTitle(result, myTiles.length);
              }
              myTiles.add(result);
              setState(() {});
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      myTiles = await TitleListData.loadTitles();
      setState(() {});
    });
  }
}
