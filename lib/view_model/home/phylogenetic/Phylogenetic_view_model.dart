import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:graphview/GraphView.dart';
import 'package:mindmapapp/model/Home/phylogenetic/node_result_model.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/Nodulo_widget.dart';
import 'package:mindmapapp/db/sqlite/edge_db.dart';
import 'package:mindmapapp/db/sqlite/node_db.dart';
import 'package:mindmapapp/db/sqlite/title_list_db.dart';

class PhylogeneticViewModel with ChangeNotifier {
  var json; // phylogenetic graphのデータ jsonで管理
  int titleID = -1; // list tiletの id この-1 というマジックナンバーは初期値(isloading の true)
  String title = ""; // start nodeのタイトル
  int maxId = 0; // nodeの最大id これを使って新しいnodeのidを生成する ダブルとstackoverflowを防ぐため
  // phylogenetic graphの生成部品
  Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  List<Map<String, dynamic>>? nodes;
  List<Map<String, int>>? edges;

  // 選択しているNodeの更新
  void setSelectedNode(int newNodeId) {
    selectedNode.value = newNodeId;
    print(selectedNode.value);
    notifyListeners();
  }

  ValueNotifier<int> selectedNode = ValueNotifier<int>(0);
  // 初期値の拡大スケールの調節
  final TransformationController controller =
      TransformationController(Matrix4.diagonal3Values(0.7, 0.7, 1.0));

  //  Nodeの最小単位
  // Node はすべてこれが生成されて表示される
  // どのnodeの子かで識別
  Widget rectangleWidget(int id, String nodeTitle) {
    return NoduloWidget(id, nodeTitle, selectedNode, setSelectedNode, createSon,
        createBro, controller, deleteNode, titleID);
  }

  void addEdge(int from, int to) {
    graph.addEdge(Node.Id(from), Node.Id(to));
    notifyListeners();
  }

  void resetZoom() {
    controller.value = Matrix4.identity();
    notifyListeners();
  }

  // グラフの初期値の形を形成
  void init(String title) {
    titleID = -1;
    title = title;
    json = <String, List>{
      "nodes": <Map<String, Object>>[
        <String, Object>{"id": 1, "label": title}
      ],
      "edges": []
    };
    graph.addNode(Node.Id(1));
    // グラフのnode間の距離とかを設定
    builder
      ..siblingSeparation = (10)
      ..levelSeparation = (35)
      ..subtreeSeparation = (35)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
    notifyListeners();
  }

  // グラフに dbから取得したデータを追加
  Future<void> initializeGraph(String title) async {
    titleID = await TitleListData.selectedTitleId(title);
    NodeResult result = await NodeData.loadNodes(titleID);
    nodes = result.nodes;
    maxId = result.maxValue; // addNnodeの一意性の担保
    edges = await EdgeData.loadEdgeds(titleID);
    if (edges!.isNotEmpty && nodes!.isNotEmpty) {
      updateGraph(<String, List<Map<String, dynamic>>?>{
        "nodes": nodes,
        "edges": edges
      });
    }
    // 最初にデフォルトの Nodeを登録する
    NodeData.addNode(1, titleID, title);
    notifyListeners();
  }

  void updateGraph(newJson) {
    json = newJson;
    var edges = json['edges']!;
    edges.forEach((element) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    });
    notifyListeners();
  }

  int addNode() {
    int newId = maxId + 1;
    maxId = newId;
    json['nodes'].add(<String, Object>{"id": newId, "label": title});
    NodeData.addNode(newId, titleID, title);
    return newId;
  }

  // 子供のnodeを追加する
  void createSon() {
    int newId = addNode();
    json['edges'].add(<String, int>{"from": selectedNode.value, "to": newId});
    addEdge(selectedNode.value, newId);
    notifyListeners();
    EdgeData.addEdge(selectedNode.value, titleID, newId);
  }

  // 兄弟のnodeを追加する
  void createBro() {
    int newId = addNode();
    var previousNode = json['edges']
        .firstWhere((element) => element["to"] == selectedNode.value);
    int previousConnection = previousNode['from'];
    json['edges']!.add(<String, int>{"from": previousConnection, "to": newId})
        as Map?;
    addEdge(previousConnection, newId);
    notifyListeners();
    EdgeData.addEdge(previousConnection, titleID, newId);
  }

  // 選択されたnodeを削除
  // 削除された nodeに関連するedgeとその他子どもnodeを削除
  void deleteNode() async {
    var edges = json['edges'];
    List<int> nodeIdArray = <int>[selectedNode.value];
    for (int i = 0; i < edges.length; i++) {
      for (int index = 0; index < nodeIdArray.length; index++) {
        if (edges[i]['from'] == nodeIdArray[index]) {
          nodeIdArray.add(edges[i]['to']);
        }
      }
    }
    notifyListeners();
    // ノードとエッジの削除を管理する
    for (int element in nodeIdArray) {
      // ノード削除
      await NodeData.deleteNode(titleID, element);
      json['nodes'].removeWhere((node) => node['id'] == element);
      // エッジ削除
      await EdgeData.deleteEdge(titleID, element);
      json['edges'].removeWhere(
          (edge) => edge['from'] == element || edge['to'] == element);
    }
  }
}
