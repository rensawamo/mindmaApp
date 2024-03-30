// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TitleListModelImpl _$$TitleListModelImplFromJson(Map<String, dynamic> json) =>
    _$TitleListModelImpl(
      id: json['id'] as int? ?? 0,
      sortId: json['sortId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
    );

Map<String, dynamic> _$$TitleListModelImplToJson(
        _$TitleListModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sortId': instance.sortId,
      'title': instance.title,
    };
