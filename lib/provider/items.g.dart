// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseItemsHash() => r'9016d7836b20ad8ba42ccf6bb4cc9cd65dc3dff5';

/// See also [FirebaseItems].
@ProviderFor(FirebaseItems)
final firebaseItemsProvider =
    AsyncNotifierProvider<FirebaseItems, List<Item>>.internal(
  FirebaseItems.new,
  name: r'firebaseItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FirebaseItems = AsyncNotifier<List<Item>>;
String _$itemsHash() => r'15417ba9d82f705307fe812b44ae31bab87a72b7';

/// See also [Items].
@ProviderFor(Items)
final itemsProvider = AutoDisposeNotifierProvider<Items, List<Item>>.internal(
  Items.new,
  name: r'itemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$itemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Items = AutoDisposeNotifier<List<Item>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
