import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wishiz/service/firebase_service.dart';

part 'firebase_service.g.dart';

@riverpod
FirebaseService firebaseService(FirebaseServiceRef ref) {
  return FirebaseService();
}
