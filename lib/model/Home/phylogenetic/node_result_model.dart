import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'node_result_model.freezed.dart';
part 'node_result_model.g.dart';

@freezed
class NodeResultModel with _$NodeResultModel {
  factory NodeResultModel({
    required List<Map<String, dynamic>> nodes,
    required int maxValue,
  }) = _NodeResultModel;

  factory NodeResultModel.fromJson(Map<String, dynamic> json) =>
      _$NodeResultModelFromJson(json);
}
