import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wishiz/provider/shared_preferences_service.dart';

part 'wrapper_state.freezed.dart';
part 'wrapper_state.g.dart';

enum WrapperStage {
  initial,
  hasKey,
  noKey,
}

@freezed
class WrapperState with _$WrapperState {
  const factory WrapperState({
    required WrapperStage stage,
  }) = _WrapperState;

  factory WrapperState.fromJson(Map<String, dynamic> json) =>
      _$WrapperStateFromJson(json);
}

class WrapperStateNotifier extends Notifier<WrapperState> {
  @override
  WrapperState build() {
    return const WrapperState(stage: WrapperStage.initial);
  }

  void keyFound(bool hasKey) {
    if (hasKey) {
      state = state.copyWith(stage: WrapperStage.hasKey);
    } else {
      state = state.copyWith(stage: WrapperStage.noKey);
    }
  }
}

final wrapperStateProvider =
    NotifierProvider<WrapperStateNotifier, WrapperState>(
  WrapperStateNotifier.new,
  dependencies: [sharedPreferencesServiceProvider],
);
