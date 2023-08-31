import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_page_state.g.dart';

@riverpod
class TabPageStateNotifier extends _$TabPageStateNotifier {
  @override
  int build() {
    return 0;
  }

  // ignore: use_setters_to_change_properties
  void set(int value) {
    state = value;
  }
}
