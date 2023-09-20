// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrapper_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WrapperState _$$_WrapperStateFromJson(Map<String, dynamic> json) =>
    _$_WrapperState(
      stage: $enumDecode(_$WrapperStageEnumMap, json['stage']),
    );

Map<String, dynamic> _$$_WrapperStateToJson(_$_WrapperState instance) =>
    <String, dynamic>{
      'stage': _$WrapperStageEnumMap[instance.stage]!,
    };

const _$WrapperStageEnumMap = {
  WrapperStage.initial: 'initial',
  WrapperStage.hasKey: 'hasKey',
  WrapperStage.noKey: 'noKey',
};
