import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishiz/service/firebase_service_response.dart';

abstract class AbstractFirebaseService {
  Future<FirebaseServiceResponse<T>> guard<T>(Future<T> Function() f) async {
    try {
      final result = await f();
      return FirebaseServiceResponse.success(result);
    } on FirebaseAuthException catch (e) {
      return FirebaseServiceResponse.error(e.code, e.message);
    } catch (e) {
      return FirebaseServiceResponse.error('unknown', e.toString());
    }
  }
}
