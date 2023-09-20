import 'package:dartsv/dartsv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

class SecureStorage {
  SecureStorage(this.uid);

  final String uid;

  final secureStorage = const FlutterSecureStorage();

  String get privateKeyKey => 'privateKey-$uid';

  Future<HDPrivateKey?> getPrivateKey() async {
    final xpriv = await secureStorage.read(key: privateKeyKey);
    if (xpriv == null) {
      return Future(() => null);
    }
    return Future(() => HDPrivateKey.fromXpriv(xpriv));
  }

  Future<void> setPrivateKey(HDPrivateKey xpriv) async {
    await secureStorage.write(key: privateKeyKey, value: xpriv.toString());
  }
}

@riverpod
SecureStorage secureStorage(SecureStorageRef ref) {
  return SecureStorage(FirebaseAuth.instance.currentUser!.uid);
}
