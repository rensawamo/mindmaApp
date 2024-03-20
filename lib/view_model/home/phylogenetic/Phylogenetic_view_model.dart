import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:graphview/GraphView.dart';

import '../../../components/Nodulo.dart';
import '../../local_strage/sqlite/edge_db.dart';
import '../../local_strage/sqlite/node_db.dart';
import '../../local_strage/sqlite/title_list_db.dart';

class PhylogeneticViewModel with ChangeNotifier {
  var json;
  var titleID = -1; // list tiletの id
  var title = ""; // start nodeのタイトル
  Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  // 選択しているNodeの更新
  setSelectedNode(newNodeId) {
    selectedNode.value = newNodeId;
    notifyListeners();
  }

  //   ----------    phylogenetic     ---------------
  var selectedNode = ValueNotifier<int>(0);
  final controller = TransformationController();

  //  Nodeの最小単位 スタートとchildで兼用
  Widget rectangleWidget(int? id, String? title) {
    return Nodulo(id, title ?? "ERROR", selectedNode, setSelectedNode,
        createSon, createBro, controller, titleID);
  }

  void addEdge(from, to) {
    graph.addEdge(Node.Id(from), Node.Id(to));
    notifyListeners();
  }

  void resetZoom() {
    controller.value = Matrix4.identity();
    notifyListeners();
  }

  void init(String title) {
    titleID = -1;
    title = "";
    json = {
      "nodes": [
        {"id": 1, "label": title}
      ],
      "edges": []
    };
    var nodes = json['nodes']!;
    graph.addNode(Node.Id(1));
    builder
      ..siblingSeparation = (20)
      ..levelSeparation = (40)
      ..subtreeSeparation = (50)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
    notifyListeners();
  }

  initializeGraph(String title) async {
    title = title;
    titleID = await TitleListData.selectedTitleId(title);
    print(titleID);
    print("tilteid");
    var nodes = await NodeData.loadNodes(titleID);
    var edges = await EdgeData.loadEdgeds(titleID);
    if (edges!.isNotEmpty && nodes!.isNotEmpty) {
      updateGraph({"nodes": nodes, "edges": edges});
    }
    // 最初にデフォルトの Nodeを登録する
    NodeData.addNode(1, titleID, title);
    notifyListeners();
  }

  addNode() {
    int newId = json["nodes"].length + 1;
    json['nodes'].add({"id": newId, "label": title});
    NodeData.addNode(newId, titleID, title);
    return newId;
  }

  void createSon() {
    int newId = addNode();
    json['edges'].add({"from": selectedNode.value, "to": newId});
    addEdge(selectedNode.value, newId);
    notifyListeners();
    EdgeData.addEdge(selectedNode.value, titleID, newId);
  }

  void createBro() {
    int newId = addNode();
    var previousNode = json['edges']
        .firstWhere((element) => element["to"] == selectedNode.value);
    int previousConnection = previousNode['from'];
    json['edges']!.add({"from": previousConnection, "to": newId}) as Map?;
    addEdge(previousConnection, newId);
    notifyListeners();
    EdgeData.addEdge(previousConnection, titleID, newId);
  }

  void deleteNode() {
    var edges = json['edges'];
    var nodes = json['nodes'];
    //Inicializa array com o valor do node selecionado
    var nodeIdArray = [selectedNode.value];
    //Passa por todas as edges
    for (var i = 0; i < edges.length; i++) {
      //Para cada edge, comparar com todos os valores da array de nódulos a serem excluidos
      for (var index = 0; index < nodeIdArray.length; index++) {
        //Quando edge vier de algum dos valores da array, deverá ser excluído também
        if (edges[i]['from'] == nodeIdArray[index]) {
          nodeIdArray.add(edges[i]['to']);
        }
      }
    }
    nodeIdArray.forEach((element) {
      json['nodes'].removeWhere((node) => node['id'] == element);
      json['edges'].removeWhere(
          (node) => node['from'] == element || node['to'] == element);
    });
    graph.removeNode(Node.Id(nodeIdArray[0]));
    notifyListeners();
  }

  updateGraph(newJson) {
    json = newJson;
    var edges = json['edges']!;
    edges.forEach((element) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    });
    notifyListeners();
  }

//   ----------    phylogenetic     ---------------
}
