// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeResultModelImpl _$$NodeResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NodeResultModelImpl(
      nodes: (json['nodes'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      maxValue: json['maxValue'] as int,
    );

Map<String, dynamic> _$$NodeResultModelImplToJson(
        _$NodeResultModelImpl instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
      'maxValue': instance.maxValue,
    };
