// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NodeResultModel _$NodeResultModelFromJson(Map<String, dynamic> json) {
  return _NodeResultModel.fromJson(json);
}

/// @nodoc
mixin _$NodeResultModel {
  List<Map<String, dynamic>> get nodes => throw _privateConstructorUsedError;
  int get maxValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeResultModelCopyWith<NodeResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeResultModelCopyWith<$Res> {
  factory $NodeResultModelCopyWith(
          NodeResultModel value, $Res Function(NodeResultModel) then) =
      _$NodeResultModelCopyWithImpl<$Res, NodeResultModel>;
  @useResult
  $Res call({List<Map<String, dynamic>> nodes, int maxValue});
}

/// @nodoc
class _$NodeResultModelCopyWithImpl<$Res, $Val extends NodeResultModel>
    implements $NodeResultModelCopyWith<$Res> {
  _$NodeResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? maxValue = null,
  }) {
    return _then(_value.copyWith(
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      maxValue: null == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NodeResultModelImplCopyWith<$Res>
    implements $NodeResultModelCopyWith<$Res> {
  factory _$$NodeResultModelImplCopyWith(_$NodeResultModelImpl value,
          $Res Function(_$NodeResultModelImpl) then) =
      __$$NodeResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Map<String, dynamic>> nodes, int maxValue});
}

/// @nodoc
class __$$NodeResultModelImplCopyWithImpl<$Res>
    extends _$NodeResultModelCopyWithImpl<$Res, _$NodeResultModelImpl>
    implements _$$NodeResultModelImplCopyWith<$Res> {
  __$$NodeResultModelImplCopyWithImpl(
      _$NodeResultModelImpl _value, $Res Function(_$NodeResultModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? maxValue = null,
  }) {
    return _then(_$NodeResultModelImpl(
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      maxValue: null == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NodeResultModelImpl
    with DiagnosticableTreeMixin
    implements _NodeResultModel {
  _$NodeResultModelImpl(
      {required final List<Map<String, dynamic>> nodes, required this.maxValue})
      : _nodes = nodes;

  factory _$NodeResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NodeResultModelImplFromJson(json);

  final List<Map<String, dynamic>> _nodes;
  @override
  List<Map<String, dynamic>> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  @override
  final int maxValue;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NodeResultModel(nodes: $nodes, maxValue: $maxValue)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NodeResultModel'))
      ..add(DiagnosticsProperty('nodes', nodes))
      ..add(DiagnosticsProperty('maxValue', maxValue));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NodeResultModelImpl &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_nodes), maxValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NodeResultModelImplCopyWith<_$NodeResultModelImpl> get copyWith =>
      __$$NodeResultModelImplCopyWithImpl<_$NodeResultModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NodeResultModelImplToJson(
      this,
    );
  }
}

abstract class _NodeResultModel implements NodeResultModel {
  factory _NodeResultModel(
      {required final List<Map<String, dynamic>> nodes,
      required final int maxValue}) = _$NodeResultModelImpl;

  factory _NodeResultModel.fromJson(Map<String, dynamic> json) =
      _$NodeResultModelImpl.fromJson;

  @override
  List<Map<String, dynamic>> get nodes;
  @override
  int get maxValue;
  @override
  @JsonKey(ignore: true)
  _$$NodeResultModelImplCopyWith<_$NodeResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
