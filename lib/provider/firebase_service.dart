import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wishiz/service/firebase_auth_service.dart';

part 'firebase_service.g.dart';

@riverpod
FirebaseAuthService firebaseService(FirebaseServiceRef ref) {
  return FirebaseAuthService();
}
