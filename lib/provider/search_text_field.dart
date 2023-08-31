import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_text_field.g.dart';

@riverpod
class SearchTextField extends _$SearchTextField {
  @override
  String build() {
    return '';
  }

  // ignore: use_setters_to_change_properties
  void setValue(String text) {
    state = text;
  }
}
