import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wishiz/model/item.dart';
import 'package:wishiz/provider/search_text_field.dart';

part 'items.g.dart';

@Riverpod(keepAlive: true)
class FirebaseItems extends _$FirebaseItems {
  @override
  FutureOr<List<Item>> build() {
    return fetchAll();
  }

  Future<List<Item>> fetchAll() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final ref = FirebaseDatabase.instance.ref('items/$userId');
    final event = await ref.once();
    final jsonData = event.snapshot.value as String?;

    if (jsonData == null) return [];

    final map = jsonDecode(jsonData) as Map<String, dynamic>;

    return [];
  }
}

@riverpod
class Items extends _$Items {
  @override
  List<Item> build() {
    final filter = ref.watch(searchTextFieldProvider);
    final firebaseItems = ref.watch(firebaseItemsProvider);

    return firebaseItems.when(
      data: (data) {
        return data
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
      },
      error: (_, __) {
        return [];
      },
      loading: () {
        return [];
      },
    );
  }
}
