// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wrapper_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WrapperState _$WrapperStateFromJson(Map<String, dynamic> json) {
  return _WrapperState.fromJson(json);
}

/// @nodoc
mixin _$WrapperState {
  WrapperStage get stage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WrapperStateCopyWith<WrapperState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WrapperStateCopyWith<$Res> {
  factory $WrapperStateCopyWith(
          WrapperState value, $Res Function(WrapperState) then) =
      _$WrapperStateCopyWithImpl<$Res, WrapperState>;
  @useResult
  $Res call({WrapperStage stage});
}

/// @nodoc
class _$WrapperStateCopyWithImpl<$Res, $Val extends WrapperState>
    implements $WrapperStateCopyWith<$Res> {
  _$WrapperStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
  }) {
    return _then(_value.copyWith(
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as WrapperStage,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WrapperStateCopyWith<$Res>
    implements $WrapperStateCopyWith<$Res> {
  factory _$$_WrapperStateCopyWith(
          _$_WrapperState value, $Res Function(_$_WrapperState) then) =
      __$$_WrapperStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WrapperStage stage});
}

/// @nodoc
class __$$_WrapperStateCopyWithImpl<$Res>
    extends _$WrapperStateCopyWithImpl<$Res, _$_WrapperState>
    implements _$$_WrapperStateCopyWith<$Res> {
  __$$_WrapperStateCopyWithImpl(
      _$_WrapperState _value, $Res Function(_$_WrapperState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
  }) {
    return _then(_$_WrapperState(
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as WrapperStage,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WrapperState implements _WrapperState {
  const _$_WrapperState({required this.stage});

  factory _$_WrapperState.fromJson(Map<String, dynamic> json) =>
      _$$_WrapperStateFromJson(json);

  @override
  final WrapperStage stage;

  @override
  String toString() {
    return 'WrapperState(stage: $stage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WrapperState &&
            (identical(other.stage, stage) || other.stage == stage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WrapperStateCopyWith<_$_WrapperState> get copyWith =>
      __$$_WrapperStateCopyWithImpl<_$_WrapperState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WrapperStateToJson(
      this,
    );
  }
}

abstract class _WrapperState implements WrapperState {
  const factory _WrapperState({required final WrapperStage stage}) =
      _$_WrapperState;

  factory _WrapperState.fromJson(Map<String, dynamic> json) =
      _$_WrapperState.fromJson;

  @override
  WrapperStage get stage;
  @override
  @JsonKey(ignore: true)
  _$$_WrapperStateCopyWith<_$_WrapperState> get copyWith =>
      throw _privateConstructorUsedError;
}
