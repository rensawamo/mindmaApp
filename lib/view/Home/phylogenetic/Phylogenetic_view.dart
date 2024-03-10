// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import 'dart:convert' as convert;

import '../../../components/Nodulo.dart';
import '../../../view_model/Home/EdgeModel.dart';
import '../../../view_model/Home/NodeModel.dart';
import '../../../view_model/Home/Phylogenetic_view_model.dart';



class PhylogeneticTreeView extends ConsumerStatefulWidget {
  const PhylogeneticTreeView({super.key});

  @override
  ConsumerState<PhylogeneticTreeView> createState() {
    return _TreeViewPageState();
  }
}

class _TreeViewPageState extends ConsumerState<PhylogeneticTreeView> {
  final viewModel = ChangeNotifierProvider((ref) => PhylogeneticViewModel());
  PhylogeneticViewModel phy =  PhylogeneticViewModel();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InteractiveViewer(
        transformationController: ref.watch(viewModel).controller,
        constrained: false,
        boundaryMargin: EdgeInsets.all(1000),
        minScale: 0.01,
        maxScale: 2,
        child: GraphView(
          graph: ref.watch(viewModel).graph,
          algorithm:
          BuchheimWalkerAlgorithm(ref.watch(viewModel).builder, TreeEdgeRenderer(ref.watch(viewModel).builder)),
          paint: Paint()
            ..color = Colors.greenAccent
            ..strokeWidth = 3
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            // I can decide what widget should be shown here based on the id
            var a = node.key!.value as int?;
            var nodes = ref.watch(viewModel).json['nodes']!;
            var nodeValue = nodes.firstWhere((element) => element['id'] == a);
            return ref.watch(viewModel).rectangleWidget(nodeValue['id'], nodeValue['label']);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    ref.read(viewModel).init();
    ref.read(viewModel).initializeGraph();
  }
}