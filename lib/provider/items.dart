import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wishiz/mock/mock_items.dart';
import 'package:wishiz/model/item.dart';
import 'package:wishiz/provider/search_text_field.dart';

part 'items.g.dart';

@riverpod
class Items extends _$Items {
  @override
  List<Item> build() {
    final filter = ref.watch(searchTextFieldProvider);
    return mockItems
        .where(
          (item) =>
              item.name.toLowerCase().contains(
                    filter.toLowerCase(),
                  ) ||
              (item.description ?? '').toLowerCase().contains(
                    filter.toLowerCase(),
                  ),
        )
        .toList();
  }
}
