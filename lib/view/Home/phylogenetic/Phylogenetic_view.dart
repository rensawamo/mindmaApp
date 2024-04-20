import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';
import 'package:mindmapapp/core/componets/loading_widget.dart';
import 'package:mindmapapp/view_model/Home/phylogenetic/Phylogenetic_view_model.dart';
import 'package:mindmapapp/core/design/app_colors.dart';

class PhylogeneticTreeView extends ConsumerStatefulWidget {
  final String title; // リストのタップされた要素
  const PhylogeneticTreeView({required this.title, super.key});

  @override
  ConsumerState<PhylogeneticTreeView> createState() => _TreeViewPageState();
}

class _TreeViewPageState extends ConsumerState<PhylogeneticTreeView> {
  final ChangeNotifierProvider<PhylogeneticViewModel> viewModel =
      ChangeNotifierProvider(
          (ChangeNotifierProviderRef<Object?> ref) => PhylogeneticViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.paleGreen,
        child: Scaffold(
            backgroundColor: AppColors.transparent,
            appBar: AppBar(
              backgroundColor: AppColors.appbarColor,
              title: Text(widget.title),
            ),
            // init処理で viewModelに前のlistで選択された titleIdが設定されるまでローディング画面を表示
            body: ref.watch(viewModel).showLoading
                ? const LoadingWidget()
                : GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: InteractiveViewer(
                      transformationController: ref.watch(viewModel).controller,
                      constrained: false,
                      boundaryMargin: const EdgeInsets.all(1000),
                      // 画面の拡大縮小の最小値と最大値を設定
                      minScale: 0.01,
                      maxScale: 2,
                      // グラフの描画
                      child: GraphView(
                        graph: ref.watch(viewModel).graph,
                        algorithm: BuchheimWalkerAlgorithm(
                          ref.watch(viewModel).builder,
                          TreeEdgeRenderer(ref.watch(viewModel).builder),
                        ),
                        paint: Paint()
                          ..color = AppColors.treeColor // 枝の色
                          ..strokeWidth = 2 // 枝の太さ
                          ..style = PaintingStyle.stroke,
                        // この builder は requireで必須で 新しい viewmodelの jsonのid更新かからないため、deleteのidが前のidと被りsqlが破壊される
                        // 描写させるために listにもどすことにした(2024/4/14)
                        builder: (Node node) {
                          int? a = node.key!.value as int?;
                          var nodes = ref.watch(viewModel).json['nodes']!;
                          var nodeValue =
                              nodes.firstWhere((element) => element['id'] == a);
                          //  各nodeを生成
                          return ref.watch(viewModel).rectangleWidget(
                              nodeValue['id'], nodeValue['label']);
                        },
                      ),
                    ),
                  )));
  }

  @override
  void initState() {
    // dbからデータを取得してグラフを作成 titleidがセットされるまでローディング画面を表示
    ref.read(viewModel).init(widget.title);
    ref.read(viewModel).initializeGraph(widget.title);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
