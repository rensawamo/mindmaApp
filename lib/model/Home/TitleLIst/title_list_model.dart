
import 'package:freezed_annotation/freezed_annotation.dart';
part 'title_list_model.freezed.dart';
part 'title_list_model.g.dart';

@Freezed()
class TitleListModel with _$TitleListModel {

  factory TitleListModel({
    @Default(0) int id,
    @Default(0) int sortId,
    @Default('') String title ,
  }) = _TitleListModel;

  factory TitleListModel.fromJson(Map<String, dynamic> json) => _$TitleListModelFromJson(json);
}
