import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindmapapp/configs/design/view+extention.dart';

import '../../../view_model/home/titlelist/title_list_view_model.dart';
import '../../../view_model/local_strage/sqlite/title_list_db.dart';

class TitleListView extends ConsumerStatefulWidget {
  const TitleListView({super.key});

  @override
  ConsumerState<TitleListView> createState() => _TitleListViewState();
}

class _TitleListViewState extends ConsumerState<TitleListView> {

  final TextEditingController _controller = TextEditingController();
  // マインドマップのタイトル
    List<String> myTiles = [];

    // listの変化量を追跡する
  List<int> createIndexMapping(List<String> before, List<String> after) {
    List<int> indexMapping = [];

    // 各要素の変更後のインデックスを追跡
    for (var item in before) {
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
      var preTitles = List<String>.from(myTiles);
      final String tile = myTiles.removeAt(oldIndex);
      myTiles.insert(newIndex, tile);
      List<int> indexMapping = createIndexMapping(preTitles, myTiles);
      TitleListData.sortChange(indexMapping);
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Re-Orderable ListView")),
      body: ReorderableListView(
        padding: const EdgeInsets.all(10),
        children: [
          for (final tile in myTiles)
            Padding(
              key: ValueKey(tile),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(tile),
                ),
              ),
            ),
        ],
        onReorder: updateMyTiles,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('新しいタイトル'),
                content: SizedBox(
                  width: context.mediaQueryWidth * .085,
                  height: context.mediaQueryHeight * .06,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'タイトル',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      print("Current text: $text");
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("閉じる"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      TitleListData.addTitle(_controller.text, myTiles.length);
                      myTiles.add(_controller.text);
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
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
