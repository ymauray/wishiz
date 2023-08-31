import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wishiz/service/shared_preferences_service.dart';

part 'shared_preferences_service.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesService sharedPreferencesService(
  SharedPreferencesServiceRef ref,
) {
  return SharedPreferencesService();
}
