import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';
import '../../../view_model/Home/phylogenetic/Phylogenetic_view_model.dart';

class PhylogeneticTreeView extends ConsumerStatefulWidget {
  final String title; // 受け取る文字列パラメータ
  const PhylogeneticTreeView({super.key, required this.title});

  @override
  ConsumerState<PhylogeneticTreeView> createState() => _TreeViewPageState();
}

class _TreeViewPageState extends ConsumerState<PhylogeneticTreeView> {
  final viewModel = ChangeNotifierProvider((ref) => PhylogeneticViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ref.watch(viewModel).titleID == -1
          ? Center(child: CircularProgressIndicator())
          : InteractiveViewer(
              transformationController: ref.watch(viewModel).controller,
              constrained: false,
              boundaryMargin: EdgeInsets.all(1000),
              minScale: 0.01,
              maxScale: 2,
              child: GraphView(
                graph: ref.watch(viewModel).graph,
                algorithm: BuchheimWalkerAlgorithm(
                  ref.watch(viewModel).builder,
                  TreeEdgeRenderer(ref.watch(viewModel).builder),
                ),
                paint: Paint()
                  ..color = Colors.greenAccent
                  ..strokeWidth = 3
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  var a = node.key!.value as int?;
                  var nodes = ref.watch(viewModel).json['nodes']!;
                  var nodeValue =
                      nodes.firstWhere((element) => element['id'] == a);
                  return ref
                      .watch(viewModel)
                      .rectangleWidget(nodeValue['id'], nodeValue['label']);
                },
              ),
            ),
    );
  }

  @override
  void initState() {
    ref.read(viewModel).init(widget.title);
    ref.read(viewModel).initializeGraph(widget.title);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
