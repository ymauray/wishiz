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
    final jsonData = (event.snapshot.value as Map<Object?, Object?>).values;

    final data = jsonData
        .map(
          (e) => Item.fromJson(
            (e as Map<Object?, Object?>).cast<String, dynamic>(),
          ),
        )
        .toList();

    return data;
  }

  FutureOr<void> add({
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required String link,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final ref = FirebaseDatabase.instance.ref('items/$userId');
    final item = Item(
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      link: link,
      id: '',
    );
    await ref.push().set(item.toJson());

    state = await AsyncValue.guard(fetchAll);
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
