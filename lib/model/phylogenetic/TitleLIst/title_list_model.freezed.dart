// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'title_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TitleListModel _$TitleListModelFromJson(Map<String, dynamic> json) {
  return _TitleListModel.fromJson(json);
}

/// @nodoc
mixin _$TitleListModel {
  int get id => throw _privateConstructorUsedError;
  int get sortId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TitleListModelCopyWith<TitleListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TitleListModelCopyWith<$Res> {
  factory $TitleListModelCopyWith(
          TitleListModel value, $Res Function(TitleListModel) then) =
      _$TitleListModelCopyWithImpl<$Res, TitleListModel>;
  @useResult
  $Res call({int id, int sortId, String title});
}

/// @nodoc
class _$TitleListModelCopyWithImpl<$Res, $Val extends TitleListModel>
    implements $TitleListModelCopyWith<$Res> {
  _$TitleListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sortId = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sortId: null == sortId
          ? _value.sortId
          : sortId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TitleListModelImplCopyWith<$Res>
    implements $TitleListModelCopyWith<$Res> {
  factory _$$TitleListModelImplCopyWith(_$TitleListModelImpl value,
          $Res Function(_$TitleListModelImpl) then) =
      __$$TitleListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int sortId, String title});
}

/// @nodoc
class __$$TitleListModelImplCopyWithImpl<$Res>
    extends _$TitleListModelCopyWithImpl<$Res, _$TitleListModelImpl>
    implements _$$TitleListModelImplCopyWith<$Res> {
  __$$TitleListModelImplCopyWithImpl(
      _$TitleListModelImpl _value, $Res Function(_$TitleListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sortId = null,
    Object? title = null,
  }) {
    return _then(_$TitleListModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sortId: null == sortId
          ? _value.sortId
          : sortId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TitleListModelImpl implements _TitleListModel {
  _$TitleListModelImpl({this.id = 0, this.sortId = 0, this.title = ''});

  factory _$TitleListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TitleListModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int sortId;
  @override
  @JsonKey()
  final String title;

  @override
  String toString() {
    return 'TitleListModel(id: $id, sortId: $sortId, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TitleListModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sortId, sortId) || other.sortId == sortId) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, sortId, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TitleListModelImplCopyWith<_$TitleListModelImpl> get copyWith =>
      __$$TitleListModelImplCopyWithImpl<_$TitleListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TitleListModelImplToJson(
      this,
    );
  }
}

abstract class _TitleListModel implements TitleListModel {
  factory _TitleListModel(
      {final int id,
      final int sortId,
      final String title}) = _$TitleListModelImpl;

  factory _TitleListModel.fromJson(Map<String, dynamic> json) =
      _$TitleListModelImpl.fromJson;

  @override
  int get id;
  @override
  int get sortId;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$TitleListModelImplCopyWith<_$TitleListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
