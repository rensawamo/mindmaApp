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

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<int>(
        future: ref.read(viewModel).init(widget.title),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            // 値が存在する場合の処理
            return InteractiveViewer(
              transformationController: ref.watch(viewModel).controller,
              constrained: false,
              boundaryMargin: EdgeInsets.all(1000),
              minScale: 0.01,
              maxScale: 2,
              child: GraphView(
                graph: ref.watch(viewModel).graph,
                algorithm:
                BuchheimWalkerAlgorithm(ref.watch(viewModel).builder,
                    TreeEdgeRenderer(ref.watch(viewModel).builder)),
                paint: Paint()
                  ..color = Colors.greenAccent
                  ..strokeWidth = 3
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  var a = node.key!.value as int?;
                  var nodes = ref.watch(viewModel).json['nodes']!;
                  var nodeValue = nodes.firstWhere((element) => element['id'] == a);
                  return ref.watch(viewModel).rectangleWidget(nodeValue['id'], nodeValue['label']);
                },
              ),
            );
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
