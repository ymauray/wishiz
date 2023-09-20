import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _instance;

  // ignore: avoid_setters_without_getters
  set sharedPreferencesInstance(SharedPreferences instance) {
    _instance = instance;
  }

  String get email => _instance.getString('email') ?? '';

  set email(String value) {
    _instance.setString('email', value);
  }
}
